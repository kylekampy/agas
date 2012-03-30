class HomeController < ApplicationController
  skip_before_filter :require_login, :all

  def show
  end

end
