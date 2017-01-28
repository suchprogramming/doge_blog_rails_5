class AdminsController < ApplicationController
  before_action :authenticate_any_scope!

  def show
    @admin = Admin.find(params[:id])
  end
end
