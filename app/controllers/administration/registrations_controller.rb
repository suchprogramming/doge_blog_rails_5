class Administration::RegistrationsController < ApplicationController
  before_action :token_valid?, only: [:new]
  after_action :mark_invite_accepted, only: [:create]

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if invite_verified? && @admin.save
      sign_in(@admin)
      redirect_to administration_dashboard_path, success: 'Welcome to the team!'
    else
      render :new
    end
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

  def mark_invite_accepted
    @invite.mark_accepted if @invite
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
