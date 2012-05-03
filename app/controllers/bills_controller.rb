class BillsController < ApplicationController
  require 'digest/md5'
  require 'uri'
  require 'net/http'
  require 'rexml/document'
  helper_method :generate_new_bill
  # GET /bills
  # GET /bills.json
  def index
    @bills = Bill.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @bills }
    end
  end

  # GET /bills/1
  # GET /bills/1.json
  def show
    @bill = Bill.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @bill }
    end
  end

  # GET /bills/new
  # GET /bills/new.json
  def new
    @bill = Bill.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @bill }
    end
  end

  # GET /bills/1/edit
  def edit
    @bill = Bill.find(params[:id])
  end

  # POST /bills
  # POST /bills.json
  def create
#    @bill = Bill.new(params[:bill])
    puts "params[:bill] = #{params[:bill]}"
    raw_bill = params[:bill]
    puts "raw_bill = #{raw_bill}"
    bill_file = raw_bill["bill_file"].tempfile
    puts "bill_file = #{bill_file}"
    @bills = generate_new_bills(bill_file)
    puts "bills = #{@bills}"
#    raise "Breaking!"
    saves_successful = true
    @bills.each do |bill|
      if(!bill_exists?(bill.unique_hash))
        puts "bill doesn't already exist!"
        saves_successful = bill.save && saves_successful
      end
    end
    respond_to do |format|
      if saves_successful
        format.html { redirect_to bills_path, :notice => 'Bill was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  # PUT /bills/1
  # PUT /bills/1.json
  def update
    @bill = Bill.find(params[:id])

    respond_to do |format|
      if @bill.update_attributes(params[:bill])
        format.html { redirect_to @bill, :notice => 'Bill was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.json
  def destroy
    @bill = Bill.find(params[:id])
    @bill.destroy

    respond_to do |format|
      format.html { redirect_to bills_url }
      format.json { head :ok }
    end
  end


#------- Some helper methods for bill generation from xml --------#
private
  
  def generate_new_bills(file)
    begin

      doc = REXML::Document.new(file)
      bills = []
      doc.elements.each("Emrs/Record") do |record|
        bill = SimpleBill.new
        bill.emr_id = record.elements["ID"].text
        bill.time = record.elements["Time"].text
        bill.date = record.elements["Date"].text
        bill.patient_id = record.elements["PatientID"].text
        bill.recorder_id = record.elements["RecorderID"].text
        if(record.elements["IsPhysician"].text == "Yes")
          bill.is_phys = true
        else
          bill.is_phys = false
        end
        if(record.elements["IsReferred"].text == "Yes")
          bill.is_referred = true
        else
          bill.is_referred = false
        end
        bill.actions = []
        bill.codes = []
        record.elements.each("Bills/Bill") do |op|
          action = {}
          action[:code] = op.elements["Code"].text
          action[:performed_by] = op.elements["PerformedBy"].text
          action[:id] = op.elements["ID"].text
          bill.actions << action
          bill.codes << action[:code]
        end
        hash = Digest::MD5.hexdigest("#{bill.date}#{bill.time}#{bill.patient_id}#{bill.recorder_id}")
        price = calc_price(bill.actions)
        nbill = Bill.new
        nbill.unique_hash = hash
        nbill.price = price
        nbill.insurance_coverage = get_coverage(bill, hash)
        if(nbill.insurance_coverage == -1)
          nbill.status = "Pending Insurance"
        else
          nbill.status = "Unpaid"
        end
        if(bill.is_phys)
          nbill.phys_id = bill.recorder_id
        else
          nbill.medstaff_id = bill.recorder_id
        end
        nbill.pat_id = bill.patient_id
        nbill.date = bill.date
        nbill.time = bill.time
        nbill.codes = bill.codes.join(",")
        nbill.payment = 0.0
        bills << nbill
      end      
      bills
    rescue Exception => e
      puts e
      puts e.backtrace
      return nil
    end
  end
  
  def calc_price(actions)
    total_price = 0
    actions.each do |action|
      price = price_for_code(action[:code])
      total_price += price
    end
    total_price
  end

  def price_for_code(code)
    return "#{code.to_i}0".to_i
  end

  def get_coverage(bill, hash)
    #Construct an XML claim file/string
    claim = ""
    claim += "<claim queryFlag=\"1\" subscriberID=\"1\" externalID=\"#{hash}\">\n"
    bill.actions.each do |action|
      claim += "\t<transaction externalID=\"#{action[:id]}\" amountBilled=\"#{price_for_code(action[:code])}\" ICD9=\"#{action[:code]}\" physicianName=\"#{get_phys_name_for_action(action)}\" medicalStaffName=\"#{get_medical_staff_name_for_action(action)}\" />\n"
    end
    claim += "</claim>"
    puts "-------------CLAIM--------------------"
    puts claim
    puts "--------------------------------------"
    signature = Digest::SHA1.hexdigest("#{Digest::SHA1.hexdigest(claim)}123Administrative Group Key456")
    puts "Signature = #{signature}"
    request = ""
    request += "<request>\n"
    request += "<client id=\"100\" signature=\"#{signature}\" />\n"
    request += claim.strip
    request += "\n</request>"
    uri = URI.parse('http://cs744.dyndns.org/services/submitClaim.php')
    http_request = Net::HTTP::Post.new(uri.path)
    http_request.body = request
    puts "----------------REQUEST--------------"
    puts http_request.body
    puts "-------------------------------------"
    http = Net::HTTP.new(uri.host, uri.port)
    response = http.request(http_request)
    puts "-------------RESPONSE----------------"
    puts response.body
    puts "-------------------------------------"
    return parse_response(response.body)
  end
  
  def parse_response(xml_response)
    begin
      total_amount_covered = 0
      doc = REXML::Document.new(xml_response)
      doc.elements.each("response/claim/transaction") do |trans|
        puts "current transacation = \"#{trans}\""
        total_amount_covered += trans.attributes["amountPaid"].to_i
      end
      return total_amount_covered
    rescue
      return -1
    end
  end

  def get_phys_name_for_action(action)
    begin
      p = Physician.find_by_id(action[:id])
      return "#{p.firstname} #{p.lastname}"
    rescue
      return ""
    end
  end

  def get_medical_staff_name_for_action(action)
    begin
      p = MedicalStaff.find_by_id(action[:id])
      return "#{p.firstname} #{p.lastname}"
    rescue
      return ""
    end
  end

  def bill_exists?(hash)
    Bill.all.each do |bill|
      if(bill.unique_hash == hash)
        return true
      end
    end
    return false
  end

  class SimpleBill
    attr_accessor :date, :time, :emr_id, :patient_id, :recorder_id, :is_phys, :is_referred, :actions, :codes

    def to_s
      "#{emr_id}: #{date} #{time} - Patient #{patient_id} with recorder #{recorder_id} and actions #{actions}"
    end
    
  end
  
end
