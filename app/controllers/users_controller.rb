class UsersController < ApplicationController
  before_action :authenticate_any_scope!

  def show
    @user = User.find(params[:id])
  end
end
