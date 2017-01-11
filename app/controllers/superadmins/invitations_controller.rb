class Superadmins::InvitationsController < ApplicationController
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
      redirect_to superadmins_invitations_path, success: 'Invite created!'
    else
      render :new
    end
  end

  private

  def deactivate_current_invites
    active_invites.each(&:mark_inactive)
  end

  def active_invites
    @active_invites = Invitation.active_invites(recipient_email)
  end

  def recipient_email
    params[:invitation][:recipient_email]
  end

  def invitation_params
    params.require(:invitation).permit(:recipient_email)
  end

end
