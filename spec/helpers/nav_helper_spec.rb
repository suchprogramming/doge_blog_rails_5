require 'rails_helper'

RSpec.describe NavHelper, :type => :helper do

  def admin
    Admin.new(id: 1, active: true, name: 'Bob Ross')
  end

  def user
    User.new(id: 1, active: true, name: 'Bob Ross')
  end

  describe '#default_links' do
    it 'returns default sign in and sign up links without a current user context' do
      expect(default_links).to include('/users/sign_in', '/users/sign_up')
    end
  end

  describe '#current_user_links' do
    it 'returns if no current user is present' do
      expect(current_user_links(nil)).to eq(nil)
    end

    it 'returns account and session links when a current user is present' do
      expect(current_user_links(user))
        .to include('/users/edit', '/users/sign_out', 'Sign Out (Bob Ross)')
    end
  end

  describe '#current_admin_links' do
    it 'returns if no current admin is present' do
      expect(current_admin_links).to eq(nil)
    end

    it 'returns if a non admin user is present' do
      expect(current_admin_links(user)).to eq(nil)
    end

    it 'returns without a link to the admin panel if an admin account is inactive' do
      inactive_admin = Admin.new(id: 2, active: false, name: 'Bad Admin')

      expect(current_admin_links(inactive_admin))
        .not_to include('/administration/dashboard')
    end

    it 'returns admin and session links when a current admin is present' do
      expect(current_admin_links(admin)).to include('/administration/dashboard',
                                                    '/admins/edit',
                                                    '/admins/sign_out',
                                                    'Sign Out (Bob Ross)')
    end
  end
end
