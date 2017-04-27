require 'rails_helper'

describe Administration::InvitationPolicy do

  subject { Administration::InvitationPolicy }

  permissions :new?, :create? do
    it 'allows a superadmin to create invites' do
      expect(subject).to permit(SuperAdmin.new, Invitation.new)
    end

    it 'denies access to inactive superadmins' do
      expect(subject).not_to permit(SuperAdmin.new(active: false), Invitation.new)
    end

    it 'denies admin access' do
      expect(subject).not_to permit(Admin.new, Invitation.new)
    end

    it 'denies access to users' do
      expect(subject).not_to permit(User.new, Invitation.new)
    end
  end
end
