require 'rails_helper'

RSpec.describe 'User management', :type => :request do

  let(:current_user) { create(:current_user) }
  let(:admin) { create(:admin) }

  context 'on the USER #show route' do
    it 'allows the current user to view a user profile' do
      login_as current_user, scope: :user

      get user_path(current_user)

      expect(response).to be_success
    end

    it 'allows the current admin to view a user profile' do
      login_as admin, scope: :admin

      get user_path(current_user)

      expect(response).to be_success
    end

    it 'redirects unauthenticated requests' do
      get user_path(current_user)

      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
