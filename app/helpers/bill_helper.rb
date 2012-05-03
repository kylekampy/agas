module BillHelper

  def get_record_list
    valid_bills = []
    files = Dir.glob(File.join(Rails.root,"public","emr","*.xml"))
    files.each do |file|
      bill = generate_new_bill(file)
      valid_bills << bill if bill != nil
    end
    valid_bills
  end

  def generate_new_bill(file)
    begin
      require 'rexml/document'
      file = File.new(file)
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
        record.elements.each("Bills/Bill") do |op|
          action = {}
          action[:code] = op.elements["Code"].text
          action[:performed_by] = op.elements["PerformedBy"].text
          action[:id] = op.elements["ID"].text
          bill.actions << action
        end
        bills << bill
      end      
      bills
    rescue Exception => e
      puts e
      puts e.backtrace
      return nil
    end
  end

  class SimpleBill
    attr_accessor :date, :time, :emr_id, :patient_id, :recorder_id, :is_phys, :is_referred, :actions

    def to_s
      "#{emr_id}: #{date} #{time} - Patient #{patient_id} with recorder #{recorder_id} and codes #{codes}"
    end

  end

end
