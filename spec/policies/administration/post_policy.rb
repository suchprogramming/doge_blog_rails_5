require 'rails_helper'

describe Administration::PostPolicy do

  subject { Administration::PostPolicy }

  permissions :update? do
    it 'grants active admin access' do
      expect(subject).to permit(Admin.new(active: true ), Post.new(id: 1))
    end

    it 'denies inactive admin access' do
      expect(subject).not_to permit(Admin.new(active: false), Post.new(id: 1))
    end

    it 'denies user access' do
      expect(subject).not_to permit(User.new(id: 1), Post.new(id: 1))
    end
  end
end
