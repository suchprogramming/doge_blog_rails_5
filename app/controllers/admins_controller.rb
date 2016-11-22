class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @admin = Admin.find(params[:id])
  end
  
end
