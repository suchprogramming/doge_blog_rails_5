require 'rails_helper'

RSpec.describe DeviseHelper, :type => :helper do
  describe '#sessions_new_password_link' do
    it 'returns nil when no controller context is available' do
      expect(sessions_new_password_link).to eq(nil)
    end

    it 'returns nil when a controller context other than sessions is provided' do
      expect(sessions_new_password_link('registrations', :user)).to eq(nil)
    end

    it 'returns a forgotten password link for a user' do
      expect(sessions_new_password_link('sessions', :user)).to include('/users/password/new')
    end

    it 'returns a forgotten password link for an admin' do
      expect(sessions_new_password_link('sessions', :admin)).to include('/admins/password/new')
    end
  end

  describe '#sessions_sign_up_link' do
    it 'returns nil when no resource name is available' do
      expect(sessions_sign_up_link).to eq(nil)
    end

    it 'returns a link for new user registration' do
      expect(sessions_sign_up_link(:user)).to include('/users/sign_up')
    end
  end
end
