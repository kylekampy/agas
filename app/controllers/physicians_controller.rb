class PhysiciansController < ApplicationController
  # GET /physicians
  # GET /physicians.json
  def index
    @physicians = Physician.all

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

    respond_to do |format|
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

  # POST /physicians
  # POST /physicians.json
  def create
    @physician = Physician.new(params[:physician])

    respond_to do |format|
      if @physician.save
        flash[:notice] = "Successfully created physician"
        redirect_to @physician
      else
        render :action => 'new'
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
end
