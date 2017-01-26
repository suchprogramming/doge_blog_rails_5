require 'rails_helper'

RSpec.describe 'Admin management', :type => :request do

  let(:admin) { create(:admin) }
  let(:super_admin) { create(:super_admin) }
  let(:current_user) { create(:current_user) }

  def updated_params
    { admin: { email: 'bobross@happytrees.com' } }
  end

  context 'on the ADMIN #index route' do
    it 'grants super admin access to the admin index' do
      login_as super_admin, scope: :admin

      get administration_admins_path

      expect(response).to be_success
    end

    it 'denies inactive super admin access' do
      login_as super_admin, scope: :admin

      super_admin.update_attributes(active: false)

      get administration_admins_path

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end

    it 'denies admin access' do
      login_as admin, scope: :admin

      get administration_admins_path

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end

    it 'denies user access' do
      login_as current_user, scope: :user

      get administration_admins_path

      expect(response).to redirect_to(new_admin_session_path)
    end

    it 'redirects unauthenticated requests' do
      get administration_admins_path

      expect(response).to redirect_to(new_admin_session_path)
    end
  end

  context 'on the ADMIN #edit route' do
    it 'grants super admin access to the admin edit route' do
      login_as super_admin, scope: :admin

      get edit_administration_admin_path(admin)

      expect(response).to be_success
    end

    it 'denies inactive super admin access' do
      login_as super_admin, scope: :admin

      super_admin.update_attributes(active: false)

      get edit_administration_admin_path(admin)

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end

    it 'denies admin access' do
      login_as admin, scope: :admin

      get edit_administration_admin_path(admin)

      expect(response).to redirect_to root_path
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end

    it 'denies user access' do
      login_as current_user, scope: :user

      get edit_administration_admin_path(admin)

      expect(response).to redirect_to new_admin_session_path
    end

    it 'redirects unauthenticated requests' do
      get edit_administration_admin_path(admin)

      expect(response).to redirect_to(new_admin_session_path)
    end
  end

  context 'on the ADMIN #update route' do
    it 'allows a super admin to edit an admin account' do
      login_as super_admin, scope: :admin

      patch administration_admin_path(admin), params: updated_params

      expect(response).to redirect_to(admin_path(admin))
      follow_redirect!

      expect(response.body).to include(updated_params[:admin][:email])
    end

    it 'denies inactive super admin access' do
      login_as super_admin, scope: :admin

      super_admin.update_attributes(active: false)

      patch administration_admin_path(admin), params: updated_params

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end

    it 'denies admin access' do
      login_as admin, scope: :admin

      patch administration_admin_path(admin), params: updated_params

      expect(response).to redirect_to root_path
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end

    it 'denies user access' do
      login_as current_user, scope: :user

      patch administration_admin_path(admin), params: updated_params

      expect(response).to redirect_to new_admin_session_path
    end

    it 'redirects unauthenticated requests' do
      patch administration_admin_path(admin)

      expect(response).to redirect_to(new_admin_session_path)
    end
  end
end
