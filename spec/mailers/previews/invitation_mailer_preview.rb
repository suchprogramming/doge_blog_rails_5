# Preview all emails at http://localhost:3000/rails/mailers/invitation_mailer
class InvitationMailerPreview < ActionMailer::Preview
  def admin_invitation
    invitation = Invitation.new(recipient_email: 'test@test.com', admin_id: 1, token: 12345)
    InvitationMailer.admin_invitation(invitation)
  end
end
