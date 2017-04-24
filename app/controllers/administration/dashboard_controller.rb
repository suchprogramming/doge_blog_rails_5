class Administration::DashboardController < ApplicationController
  before_action :authenticate_admin!

  def posts
    authorize :dashboard, :active_admin?
    @posts = Post.filter(params.slice(:post_search)).page(params[:page]).order(created_at: :desc)
  end

  def users
    authorize :dashboard, :active_admin?
    @users = User.filter(params.slice(:user_search)).page(params[:page]).order(created_at: :desc)
  end

  def comments
    authorize :dashboard, :active_admin?
    @comments = Comment.filter(params.slice(:comment_search)).page(params[:page]).order(created_at: :desc)
  end

  def admins
    authorize :dashboard, :active_super_admin?
    @admins = Admin.filter(params.slice(:admin_search)).page(params[:page]).order(created_at: :desc)
  end

  def invitations
    authorize :dashboard, :active_super_admin?
    @invites = Invitation.filter(params.slice(:invite_search)).page(params[:page]).order(created_at: :desc)
  end
end
