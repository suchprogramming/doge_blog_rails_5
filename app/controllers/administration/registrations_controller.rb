class Administration::RegistrationsController < ApplicationController
  before_action :token_valid?, only: [:new]

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save(context: :new_invitation)
      sign_in(@admin)
      redirect_to administration_dashboard_posts_path, success: 'Welcome to the team!'
    else
      render :new
    end
  end

  private

  def token_valid?
    default_pundit_action if Invitation.valid_invite_token(params[:token]).empty?
  end

  def admin_params
    params.require(:admin).permit(:email, :name, :password, :password_confirmation, :token)
  end
end
