class BillsController < ApplicationController
  before_filter :authorize_administrator

  def new
  end
  
  def create
    render :action => 'new'
  end

end
