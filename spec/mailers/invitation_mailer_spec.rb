require "rails_helper"

RSpec.describe InvitationMailer, type: :mailer do

  let(:invitation) { create(:invitation) }

  describe '#admin_invitation' do
    let(:mail) { InvitationMailer.admin_invitation(invitation) }

    it 'renders headers properly' do
      expect(mail.subject).to eq('Welcome to the admin team!')
      expect(mail.from).to eq(['notifications@thedogeblog.com'])
      expect(mail.to).to eq([invitation.recipient_email])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include('Welcome to The Doge Blog!')
      expect(mail.body.encoded).to include(invitation.invite_link)
    end

    it 'queues the correct email for delivery' do
      mail.deliver_now

      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(ActionMailer::Base.deliveries.first).to eq(mail)
    end
  end

end
