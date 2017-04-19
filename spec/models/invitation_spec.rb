require 'rails_helper'

RSpec.describe Invitation, type: :model do

  let(:invitation) { create(:invitation) }

  it { should belong_to(:admin) }
  it { should validate_presence_of(:recipient_email) }

  describe '.valid_invite_token' do
    it 'should return invites within the expiry range with a valid token' do
      expect(Invitation.valid_invite_token(invitation.token).first)
        .to eq(invitation)
    end

    it 'should ignore invites outside of the expiry range' do
      invitation.update(expires_at: 1.week.ago)

      expect(Invitation.valid_invite_token(invitation.token)).to eq([])
    end
  end

  describe '.active_user_invites' do
    it 'returns an active invite for a given recipient email' do
      expect(Invitation.active_user_invites(invitation.recipient_email).first)
        .to eq(invitation)
    end

    it 'ignores invites that have been marked inactive' do
      invitation.update(expires_at: nil)

      expect(Invitation.active_user_invites(invitation.recipient_email)).to eq([])
    end
  end

  describe '#has_secure_token' do
    it 'should generate a token on creation' do
      expect(invitation.token).not_to be(nil)
    end
  end

  describe '#set_expiration_date' do
    it 'should set an expiration date of 24 hours on creation' do
      expect(invitation.expires_at.change(sec: 0))
        .to eq(24.hours.from_now.change(sec: 0))
    end
  end

  describe '#mark_inactive' do
    it 'should mark all pending invites inactive before creation' do
      super_admin = create(:super_admin)
      invitation_pair = create_pair(:invitation, admin: super_admin)

      expect(Invitation.active_user_invites('new_admin@admin.com').count).to eq(1)
    end
  end
end
