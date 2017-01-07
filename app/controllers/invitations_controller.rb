class InvitationsController < ApplicationController
  before_action :authenticate_admin!
  before_action :deactivate_current_invites, only: [:create]

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
      redirect_to superadmin_invitations_path, success: 'Invite created!'
    else
      render :new
    end
  end

  private

  def deactivate_current_invites
    @active_invites = Invitation.where(recipient_email: recipient_email)
    @active_invites.update_all(active: false) unless @active_invites.empty?
  end

  def recipient_email
    params[:invitation][:recipient_email]
  end

  def invitation_params
    params.require(:invitation).permit(:recipient_email)
  end

end
