class AdminsController < ApplicationController
  before_action :authenticate_admin!, except: [:new, :create]
  before_action :token_valid?, only: [:new]
  after_action :mark_invite_inactive, only: [:create]

  def index
    @posts = Post.search(params[:post_search])
    @users = User.search(params[:user_search])
  end

  def new
    @admin = Admin.new
  end

  def show
    @admin = Admin.find(params[:id])
  end

  def create
    @admin = Admin.new(admin_params)
    if invite_verified? && @admin.save
      sign_in(@admin)
      redirect_to admins_path, success: 'Welcome to the team!'
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  private

  def token_valid?
    @token = Invitation.find_by(token: params[:token], active: true).try(:token)
    default_pundit_action unless @token
  end

  def invite_verified?
    @invite = Invitation.find_by(valid_invite_params)
    return false unless @invite
  end

  def mark_invite_inactive
    @invite.update_attributes(active: false, accepted_at: Time.now) if @invite
  end

  def valid_invite_params
    {
      token: params[:token],
      recipient_email: params[:admin][:email],
      active: true
    }
  end

  def admin_params
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end

end
