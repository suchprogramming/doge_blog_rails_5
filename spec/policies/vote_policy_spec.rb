require 'rails_helper'

describe VotePolicy do

  subject { VotePolicy }

  permissions :create? do
    it 'should allow active users to create a vote' do
      expect(subject).to permit(User.new(id: 1), Vote.new(user_id: 1))
    end

    it 'should deny access to inactive users' do
      expect(subject).not_to permit(User.new(id: 1, active: false), Vote.new(user_id: 1))
    end

    it 'should deny access if params are not matched' do
      expect(subject).not_to permit(User.new(id: 1), Vote.new(user_id: 2))
    end

    it 'should deny access to admins' do
      expect(subject).not_to permit(Admin.new(id: 1), Vote.new(user_id: 1))
      expect(subject).not_to permit(SuperAdmin.new(id: 1), Vote.new(user_id: 1))
    end
  end
end
