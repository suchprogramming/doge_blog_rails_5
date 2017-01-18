require 'rails_helper'

describe AdminPolicy do

  subject { AdminPolicy }

  permissions :index? do
    it 'grants superadmin access' do
      expect(subject).to permit(SuperAdmin.new)
    end

    it 'denies inactive superadmin access' do
      expect(subject).not_to permit(SuperAdmin.new(active: false))
    end

    it 'denies admin access' do
      expect(subject).not_to permit(Admin.new)
    end

    it 'denies user access' do
      expect(subject).not_to permit(User.new)
    end
  end

  permissions :edit?, :update? do
    it 'grants superadmin access to their own resource' do
      expect(subject).to permit(SuperAdmin.new(id: 1), SuperAdmin.new(id: 1))
    end

    it 'grants superadmin access to admin resources' do
      expect(subject).to permit(SuperAdmin.new, Admin.new)
    end

    it 'grants admin access to their own resource' do
      expect(subject).to permit(Admin.new(id: 1), Admin.new(id: 1))
    end

    it 'denies inactive superadmin access' do
      expect(subject).not_to permit(SuperAdmin.new(active: false), Admin.new)
    end

    it 'denies inactive admin access' do
      expect(subject).not_to permit(Admin.new(active: false), Admin.new)
    end

    it 'denies admin access to other admin resources' do
      expect(subject).not_to permit(Admin.new(id: 1), Admin.new(id: 2))
    end

    it 'denies user access' do
      expect(subject).not_to permit(User.new, User.new)
    end
  end
end
