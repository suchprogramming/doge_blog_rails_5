class Administration::AdminsController < ApplicationController
  before_action :authenticate_admin!

  def edit
    @admin = Admin.find(params[:id])
    authorize [:administration, @admin]
  end

  def update
    @admin = Admin.find(params[:id])
    authorize [:administration, @admin]
    if @admin.update(admin_params)
      redirect_to admin_path(@admin), success: 'Admin updated successfully!'
    else
      render :edit
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:email, :name, :active, :avatar_approved)
  end
end
