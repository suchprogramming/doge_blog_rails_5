class Administration::InvitationsController < ApplicationController
  before_action :authenticate_admin!

  def new
    @invitation = Invitation.new
    authorize [:administration, @invitation]
  end

  def create
    @invitation = current_admin.invitations.new(invitation_params)
    authorize [:administration, @invitation]
    if @invitation.save
      InvitationMailer.admin_invitation(@invitation).deliver_now
      redirect_to administration_dashboard_invitations_path, success: 'Invite created!'
    else
      render :new
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:recipient_email)
  end
end
