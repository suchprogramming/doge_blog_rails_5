class Administration::DashboardController < ApplicationController
  before_action :authenticate_admin!

  def posts
    authorize [:administration, :dashboard]
    @posts = Post.filter(params.slice(:post_search)).page(params[:page]).order(created_at: :desc)
  end

  def users
    authorize [:administration, :dashboard]
    @users = User.filter(params.slice(:user_search)).page(params[:page]).order(created_at: :desc)
  end

  def comments
    authorize [:administration, :dashboard]
    @comments = Comment.filter(params.slice(:comment_search)).page(params[:page]).order(created_at: :desc)
  end

  def admins
    authorize [:administration, :dashboard]
    @admins = Admin.filter(params.slice(:admin_search)).page(params[:page]).order(created_at: :desc)
  end

  def invitations
    authorize [:administration, :dashboard]
    @invites = Invitation.filter(params.slice(:invite_search)).page(params[:page]).order(created_at: :desc)
  end
end
