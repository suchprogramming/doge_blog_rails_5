class Administration::UsersController < ApplicationController
  before_action :authenticate_admin!

  def edit
    @user = User.find(params[:id])
    authorize [:administration, @user]
  end

  def update
    @user = User.find(params[:id])
    authorize [:administration, @user]
    if @user.update(user_params)
      redirect_to user_path(@user), success: "User updated successfully!"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :active, :avatar_approved)
  end
end
