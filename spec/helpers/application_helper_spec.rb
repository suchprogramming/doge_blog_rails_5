require 'rails_helper'

RSpec.describe ApplicationHelper, :type => :helper do

  describe '#current_superadmin' do
    it 'returns a superadmin instance if the current user scope is a SuperAdmin' do
      superadmin = SuperAdmin.new

      expect(current_superadmin(superadmin)).to eq(true)
    end

    it 'returns if the current user scope is a user' do
      expect(current_superadmin(User.new)).to eq(nil)
    end

    it 'returns if the current user scope is an admin' do
      expect(current_superadmin(Admin.new)).to eq(nil)
    end
  end
end
