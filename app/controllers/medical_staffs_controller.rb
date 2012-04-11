class MedicalStaffsController < ApplicationController
  # GET /medical_staffs
  # GET /medical_staffs.json
  def index
    @medical_staffs = MedicalStaff.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @medical_staffs }
      format.xml #index.xml.builder
    end
  end

  # GET /medical_staffs/1
  # GET /medical_staffs/1.json
  def show
    @medical_staff = MedicalStaff.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @medical_staff }
      format.xml #show.xml.builder
    end
  end

  # GET /medical_staffs/new
  # GET /medical_staffs/new.json
  def new
    @medical_staff = MedicalStaff.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @medical_staff }
    end
  end

  # GET /medical_staffs/1/edit
  def edit
    @medical_staff = MedicalStaff.find(params[:id])
  end

  # POST /medical_staffs
  # POST /medical_staffs.json
  def create
    @medical_staff = MedicalStaff.new(params[:medical_staff])

    respond_to do |format|
      if @medical_staff.save
        format.html { redirect_to @medical_staff, :notice => 'Medical staff was successfully created.' }
        format.json { render :json => @medical_staff, :status => :created, :location => @medical_staff }
      else
        format.html { render :action => "new" }
        format.json { render :json => @medical_staff.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /medical_staffs/1
  # PUT /medical_staffs/1.json
  def update
    @medical_staff = MedicalStaff.find(params[:id])

    respond_to do |format|
      if @medical_staff.update_attributes(params[:medical_staff])
        format.html { redirect_to @medical_staff, :notice => 'Medical staff was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @medical_staff.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /medical_staffs/1
  # DELETE /medical_staffs/1.json
  def destroy
    @medical_staff = MedicalStaff.find(params[:id])
    @medical_staff.destroy

    respond_to do |format|
      format.html { redirect_to medical_staffs_url }
      format.json { head :ok }
    end
  end
end
