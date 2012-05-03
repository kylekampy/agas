class PhysiciansController < ApplicationController
  before_filter :authorize_administrator, :only => [:index, :new, :create, :destroy]
    helper_method :sort_column, :sort_direction

  #If you aren't an admin, you are a physician. AppControl requires a login to begin with.

  # GET /physicians
  # GET /physicians.json
  def index
    @physicians = Physician.order(sort_column + " " + sort_direction)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @physicians }
      format.xml #index.xml.builder
    end
  end

  # GET /physicians/1
  # GET /physicians/1.json
  def show
    @physician = Physician.find(params[:id])
    #todo: authorize we are the correct physician.

    respond_to do |format|
      format.html
      format.xml #show.xml.builder
    end
  end

  # GET /physicians/new
  # GET /physicians/new.json
  def new
    @physician = Physician.new
    @physician.build_login
  end

  # GET /physicians/1/edit
  def edit
    @physician = Physician.find(params[:id])
  end
  
  def edit_password
    @physician = Physician.find(params[:id])

  end

  # POST /physicians
  # POST /physicians.json
  def create
    @physician = Physician.new(params[:physician])

    respond_to do |format|
      if @physician.save
        format.html { redirect_to @physician, :notice => 'Physician was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "new" }
        format.json { render :json => @physician.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /physicians/1
  # PUT /physicians/1.json
  def update
    @physician = Physician.find(params[:id])

    respond_to do |format|
      if @physician.update_attributes(params[:physician])
        format.html { redirect_to @physician, :notice => 'Physician was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @physician.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /physicians/1
  # DELETE /physicians/1.json
  def destroy
    @physician = Physician.find(params[:id])
    @physician.destroy

    respond_to do |format|
      format.html { redirect_to physicians_url }
      format.json { head :ok }
    end
  end
  
    private
  
  def sort_column
    Physician.column_names.include?(params[:sort]) ? params[:sort] : "lastname"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
