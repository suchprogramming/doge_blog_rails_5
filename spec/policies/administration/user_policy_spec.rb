require 'rails_helper'

describe Administration::UserPolicy do

  subject { Administration::UserPolicy }

  permissions :edit?, :update? do
    it 'grants active admin access' do
      expect(subject).to permit(Admin.new(active: true ), User.new)
    end

    it 'denies inactive admin access' do
      expect(subject).not_to permit(Admin.new(active: false), User.new)
    end

    it 'denies user access' do
      expect(subject).not_to permit(User.new, User.new)
    end
  end
end
