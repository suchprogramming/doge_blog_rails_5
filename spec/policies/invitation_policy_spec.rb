require 'rails_helper'

describe InvitationPolicy do

  subject { InvitationPolicy }

  permissions :index? do
    it 'grants an admin access to the invitation list' do
      expect(subject).to permit(Admin.new, Invitation.new)
    end

    it 'grants a superadmin access to the invitation list' do
      expect(subject).to permit(SuperAdmin.new, Invitation.new)
    end

    it 'denies access to inactive superadmins' do
      expect(subject).not_to permit(SuperAdmin.new(active: false), Invitation.new)
    end

    it 'denies access to inactive admins' do
      expect(subject).not_to permit(Admin.new(active: false), Invitation.new)
    end

    it 'denies access to user objects' do
      expect(subject).not_to permit(User.new, Invitation.new)
    end
  end

  permissions :new?, :create? do
    it 'allows a superadmin to create invites' do
      expect(subject).to permit(SuperAdmin.new, Invitation.new)
    end

    it 'denies access to inactive superadmins' do
      expect(subject).not_to permit(SuperAdmin.new(active: false), Invitation.new)
    end

    it 'denies regular admin access' do
      expect(subject).not_to permit(Admin.new, Invitation.new)
    end

    it 'denies access to user objects' do
      expect(subject).not_to permit(User.new, Invitation.new)
    end
  end
end
