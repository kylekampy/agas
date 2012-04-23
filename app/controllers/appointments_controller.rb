class AppointmentsController < ApplicationController
  before_filter :authorize_at_least_medical_staff
      helper_method :sort_column, :sort_direction


  # GET /appointments
  # GET /appointments.json
  def index
    @appointments = Appointment.order(sort_column + " " + sort_direction)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @appointments }
      format.xml #index.xml.builder
    end
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
    @appointment = Appointment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @appointment }
      format.xml #show.xml.builder
    end
  end

  # GET /appointments/new
  # GET /appointments/new.json
  def new
    @appointment = Appointment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @appointment }
    end
  end

  # GET /appointments/1/edit
  def edit
    @appointment = Appointment.find(params[:id])
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(params[:appointment])

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, :notice => 'Appointment was successfully created.' }
        format.json { render :json => @appointment, :status => :created, :location => @appointment }
      else
        format.html { render :action => "new" }
        format.json { render :json => @appointment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /appointments/1
  # PUT /appointments/1.json
  def update
    @appointment = Appointment.find(params[:id])

    respond_to do |format|
      if @appointment.update_attributes(params[:appointment])
        format.html { redirect_to @appointment, :notice => 'Appointment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @appointment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy

    respond_to do |format|
      format.html { redirect_to appointments_url }
      format.json { head :ok }
    end
  end
  
    private
  
  def sort_column
    Schedule.column_names.include?(params[:sort]) ? params[:sort] : "start_time"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
