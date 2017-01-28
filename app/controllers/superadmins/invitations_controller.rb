class Superadmins::InvitationsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @invitations = Invitation.all
    authorize @invitations
  end

  def new
    @invitation = Invitation.new
    authorize @invitation
  end

  def create
    @invitation = current_admin.invitations.new(invitation_params)
    authorize @invitation
    if @invitation.save
      InvitationMailer.admin_invitation(@invitation).deliver_now
      redirect_to superadmins_invitations_path, success: 'Invite created!'
    else
      render :new
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:recipient_email)
  end

end
