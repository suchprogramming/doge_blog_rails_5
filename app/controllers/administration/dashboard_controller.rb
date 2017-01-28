class Administration::DashboardController < ApplicationController
  before_action :authenticate_admin!

  def index
    authorize :dashboard, :index?
    @posts = Post.search(params[:post_search]).limit(10).order(created_at: :desc)
    @users = User.search(params[:user_search]).limit(10).order(updated_at: :desc)
  end
end
