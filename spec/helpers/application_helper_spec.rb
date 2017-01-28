require 'rails_helper'

RSpec.describe ApplicationHelper, :type => :helper do

  describe '#current_superadmin' do
    it 'returns true if the current user scope is an active SuperAdmin' do
      super_admin = SuperAdmin.new

      expect(current_superadmin(super_admin)).to eq(true)
    end

    it 'returns if the current user scope is an inactive SuperAdmin' do
      super_admin = SuperAdmin.new(active: false)

      expect(current_superadmin(super_admin)).to eq(false)
    end

    it 'returns if the current user scope is a user' do
      expect(current_superadmin(User.new)).to eq(nil)
    end

    it 'returns if the current user scope is an admin' do
      expect(current_superadmin(Admin.new)).to eq(nil)
    end
  end
end
