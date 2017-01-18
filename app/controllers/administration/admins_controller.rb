class Administration::AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @admins = Admin.all
    authorize @admins
  end

  def edit
    @admin = Admin.find(params[:id])
    authorize @admin
  end

  def update
    @admin = Admin.find(params[:id])
    authorize @admin
    if @admin.update(admin_params)
      redirect_to admin_path(@admin), success: 'Admin updated successfully!'
    else
      render :edit
    end
  end

  def update_password
    @admin = Admin.find(params[:id])
    authorize @admin
    if @admin.update_with_password(admin_pass_params)
      bypass_sign_in(@admin)
      redirect_to admin_path(@admin), success: 'Password updated successfully!'
    else
      render :edit
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:email, :active)
  end

end
