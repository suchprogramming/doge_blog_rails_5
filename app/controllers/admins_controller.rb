class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
  end
  
  def show
    @admin = Admin.find(params[:id])
  end

end
