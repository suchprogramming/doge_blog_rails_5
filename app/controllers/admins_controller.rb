class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.search(params[:post_search])
    @users = User.search(params[:user_search])
  end

  def show
    @admin = Admin.find(params[:id])
  end

end
