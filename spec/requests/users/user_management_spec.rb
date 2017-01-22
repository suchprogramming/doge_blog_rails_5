require 'rails_helper'

RSpec.describe 'User management', :type => :request do

  let(:current_user) { create(:current_user) }
  let(:alternate_user) { create(:alternate_user) }
  let(:admin) { create(:admin) }

  def user_params
    { user: { email: 'updated@email.com' } }
  end

  context 'on the USER #show route' do
    it 'redirects unauthenticated requests' do
      get user_path(current_user)

      expect(response).to redirect_to(new_user_session_path)
    end

    it 'allows the current_user to view a user profile' do
      login_as current_user, scope: :user

      get user_path(current_user)

      expect(response).to be_success
    end
  end

  context 'on the USER #edit route' do
    it 'redirects unauthenticated requests' do
      get edit_administration_user_path(current_user)

      expect(response).to redirect_to(new_admin_session_path)
    end

    it 'redirects non admin users' do
      login_as current_user, scope: :user

      get edit_administration_user_path(current_user)

      expect(response).to redirect_to(new_admin_session_path)
    end

    it 'allows admin access' do
      login_as admin

      get edit_administration_user_path(current_user)

      expect(response).to be_success
    end

  end

  context 'on the USER #update route' do
    it 'redirects unauthenticated requests' do
      patch administration_user_path(current_user), params: user_params

      expect(response).to redirect_to(new_admin_session_path)
    end

    it 'redirects non admin users' do
      login_as current_user

      patch administration_user_path(current_user), params: user_params

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include('You are not authorized to perform this action.')
    end

    it 'allows admins to edit user accounts' do
      login_as admin

      patch administration_user_path(current_user), params: user_params

      expect(response).to redirect_to(user_path(current_user))
      follow_redirect!

      expect(response.body).to include('User updated successfully!')
    end
  end
end
