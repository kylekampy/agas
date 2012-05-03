class SchedulesController < ApplicationController
  before_filter :authorize_at_least_medical_staff
  helper_method :sort_column, :sort_direction
  helper_method :available_times

  #Todo: add auth for schedules in individual methods

  # GET /schedules
  # GET /schedules.json
  def index

    if(is_admin)
       @schedules = Schedule.order(sort_column + " " + sort_direction).page(params[:page])
    elsif(is_phys) 
       @schedules = Schedule.where(:phy_id => current_user.id).order(sort_column + " " + sort_direction).page(params[:page])
    elsif(is_medstaff)
       @schedules = Schedule.where(:phy_id => current_user.doc_id).order(sort_column + " " + sort_direction).page(params[:page])
    end
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /schedules/1
  # GET /schedules/1.json
  def show
    @schedule = Schedule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
     end
  end

  # GET /schedules/new
  # GET /schedules/new.json
  def new
    @schedule = Schedule.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @schedule }
    end
  end

  # GET /schedules/1/edit
  def edit
    @schedule = Schedule.find(params[:id])
  end

  # POST /schedules
  # POST /schedules.json
  def create
    @schedule = Schedule.new(params[:schedule])

    respond_to do |format|
      if @schedule.save
        format.html { redirect_to @schedule, :notice => 'Schedule was successfully created.' }
        format.json { render :json => @schedule, :status => :created, :location => @schedule }
      else
        format.html { render :action => "new" }
        format.json { render :json => @schedule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /schedules/1
  # PUT /schedules/1.json
  def update
    @schedule = Schedule.find(params[:id])

    respond_to do |format|
      if @schedule.update_attributes(params[:schedule])
        format.html { redirect_to @schedule, :notice => 'Schedule was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @schedule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy

    respond_to do |format|
      format.html { redirect_to schedules_url }
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
