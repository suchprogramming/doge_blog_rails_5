class UsersController < ApplicationController
  before_action :authenticate_any_scope!

  def index
    @users = User.all
    authorize User
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update(user_params)
      redirect_to user_path(@user), success: "User updated successfully!"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end

end
