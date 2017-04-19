require 'rails_helper'

RSpec.describe 'Superadmin invitation management', :type => :request do

  let(:admin) { create(:admin) }
  let(:invitation) { create(:invitation) }
  let(:current_user) { create(:current_user) }

  def super_admin
    invitation.admin
  end

  def invite_params
    { invitation: { recipient_email: 'new_admin@admin.com'} }
  end

  context 'on the INVITATION #index route' do
    it 'grants super admin access to the invitations index' do
      login_as super_admin, scope: :admin

      get superadmins_invitations_path

      expect(response).to be_success
    end

    it 'denies inactive superadmin access' do
      login_as super_admin, scope: :admin

      super_admin.update(active: false)

      get superadmins_invitations_path

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end

    it 'denies admin access' do
      login_as admin, scope: :admin

      get superadmins_invitations_path

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end

    it 'denies user access' do
      login_as current_user, scope: :user

      get superadmins_invitations_path

      expect(response).to redirect_to(new_admin_session_path)
    end

    it 'redirects unauthenticated requests' do
      get superadmins_invitations_path

      expect(response).to redirect_to(new_admin_session_path)
    end
  end

  context 'on the INVITATION #new route' do
    it 'grants a superadmin access to the new invitation route' do
      login_as super_admin, scope: :admin

      get new_superadmins_invitation_path

      expect(response).to be_success
    end

    it 'denies inactive superadmin access' do
      login_as super_admin, scope: :admin

      super_admin.update(active: false)

      get new_superadmins_invitation_path

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end

    it 'denies admin access' do
      login_as admin, scope: :admin

      get new_superadmins_invitation_path

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end

    it 'denies user access' do
      login_as current_user, scope: :user

      get new_superadmins_invitation_path

      expect(response).to redirect_to(new_admin_session_path)
    end

    it 'redirects unauthenticated requests' do
      get superadmins_invitations_path

      expect(response).to redirect_to(new_admin_session_path)
    end
  end

  context 'on the INVITATION #create route' do
    it 'allows a superadmin to create a new invitation' do
      login_as super_admin, scope: :admin

      post superadmins_invitations_path, params: invite_params
      follow_redirect!

      expect(response.body).to include('Invite created!')
    end

    it 'denies inactive superadmin access' do
      login_as super_admin, scope: :admin

      super_admin.update(active: false)

      post superadmins_invitations_path, params: invite_params

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end

    it 'denies admin access' do
      login_as admin, scope: :admin

      post superadmins_invitations_path, params: invite_params
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end

    it 'denies user access' do
      login_as current_user, scope: :user

      post superadmins_invitations_path, params: invite_params

      expect(response).to redirect_to(new_admin_session_path)
    end

    it 'redirects unauthenticated requests' do
      get superadmins_invitations_path

      expect(response).to redirect_to(new_admin_session_path)
    end
  end
end
