class Administration::AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @admins = Admin.search(params[:admin_search]).limit(10).order(updated_at: :desc)
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

  private

  def admin_params
    params.require(:admin).permit(:email, :active, :avatar_approved)
  end

end
