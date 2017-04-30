require 'rails_helper'

describe Administration::DashboardPolicy do

  subject { Administration::DashboardPolicy }

  permissions :posts?, :comments?, :users? do
    it 'should grant access to active superadmins' do
      expect(subject).to permit(SuperAdmin.new)
    end

    it 'should grant access to active admins' do
      expect(subject).to permit(Admin.new)
    end

    it 'should reject inactive superadmin access' do
      expect(subject).not_to permit(SuperAdmin.new(active: false))
    end

    it 'should reject inactive admin access' do
      expect(subject).not_to permit(Admin.new(active: false))
    end

    it 'should reject user access' do
      expect(subject).not_to permit(User.new)
    end
  end

  permissions :admins?, :invitations? do
    it 'should grant access to active superadmins' do
      expect(subject).to permit(SuperAdmin.new)
    end

    it 'should reject admins' do
      expect(subject).not_to permit(Admin.new)
    end

    it 'should reject inactive superadmin access' do
      expect(subject).not_to permit(SuperAdmin.new(active: false))
    end

    it 'should reject inactive admin access' do
      expect(subject).not_to permit(Admin.new(active: false))
    end

    it 'should reject user access' do
      expect(subject).not_to permit(User.new)
    end
  end
end
