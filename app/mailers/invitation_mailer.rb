class InvitationMailer < ApplicationMailer
  default from: 'notifications@thedogeblog.com'

  def admin_invitation(invitation)
    @invitation = invitation
    @url  = "#{root_url + @invitation.invite_link}"
    mail(to: @invitation.recipient_email, subject: 'Welcome to the Admin team!')
  end
end
