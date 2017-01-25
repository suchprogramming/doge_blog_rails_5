require 'rails_helper'

describe UserPolicy do

  let(:user) { User.new(id: 1) }
  let(:admin) { Admin.new(active: true ) }

  subject { UserPolicy }

  permissions :index?, :edit?, :update? do
    it 'grants active admin access' do
      expect(subject).to permit(admin, user)
    end

    it 'denies inactive admin access' do
      expect(subject).not_to permit(Admin.new(active: false), user)
    end

    it 'denies user access' do
      expect(subject).not_to permit(user, user)
    end
  end

  permissions :show? do
    it 'allows you to view your own profile' do
      expect(subject).to permit(user, user)
    end

    it 'allows you to view any user profile' do
      expect(subject).to permit(user, User.new(id: 2))
    end
  end
end
