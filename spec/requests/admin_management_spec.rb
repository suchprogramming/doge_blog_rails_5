require "rails_helper"

RSpec.describe "Admin management", :type => :request do

  let(:admin) { create(:admin) }
  let(:superadmin) { create(:superadmin) }
  let(:current_user) { create(:current_user) }

  def updated_params
    { admin: { email: 'bobross@happytrees.com' } }
  end

  context 'on the ADMIN #index route' do
    it 'redirects unauthenticated requests' do
      get administration_admins_path

      expect(response).to redirect_to(new_admin_session_path)
    end

    it 'allows superadmin access' do
      login_as superadmin, scope: :admin

      get administration_admins_path

      expect(response).to be_success
    end

    it 'denies admin access' do
      login_as admin, scope: :admin

      get administration_admins_path

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include('You are not authorized to perform this action.')
    end

    it 'denies user access' do
      login_as current_user, scope: :user

      get administration_admins_path

      expect(response).to redirect_to(new_admin_session_path)
    end
  end

  context 'on the ADMIN #edit route' do
    it 'redirects unauthenticated requests' do
      get edit_administration_admin_path(admin)

      expect(response).to redirect_to(new_admin_session_path)
    end

    it 'grants superadmin access to their own resource' do
      login_as superadmin, scope: :admin

      get edit_administration_admin_path(superadmin)

      expect(response).to be_success
    end

    it 'grants superadmin access to an admin resource' do
      login_as superadmin, scope: :admin

      get edit_administration_admin_path(admin)

      expect(response).to be_success
    end

    it 'grants admin access to their own resource' do
      login_as admin, scope: :admin

      get edit_administration_admin_path(admin)

      expect(response).to be_success
    end

    it 'denies admin access to another admin resource' do
      login_as admin, scope: :admin

      get edit_administration_admin_path(superadmin)

      expect(response).to redirect_to root_path
      follow_redirect!

      expect(response.body).to include('You are not authorized to perform this action.')
    end

    it 'denies user access' do
      login_as current_user, scope: :user

      get edit_administration_admin_path(admin)

      expect(response).to redirect_to new_admin_session_path
    end
  end

  context 'on the ADMIN #update route' do
    it 'redirects unauthenticated requests' do
      patch administration_admin_path(admin)

      expect(response).to redirect_to(new_admin_session_path)
    end

    it 'allows a superadmin to edit their account' do
      login_as superadmin, scope: :admin

      patch administration_admin_path(superadmin), params: updated_params

      expect(response).to redirect_to(admin_path(superadmin))
      follow_redirect!

      expect(response.body).to include(updated_params[:admin][:email])
    end

    it 'allows a superadmin to edit an admin account' do
      login_as superadmin, scope: :admin

      patch administration_admin_path(admin), params: updated_params

      expect(response).to redirect_to(admin_path(admin))
      follow_redirect!

      expect(response.body).to include(updated_params[:admin][:email])
    end

    it 'allows an admin to update their account' do
      login_as admin, scope: :admin

      patch administration_admin_path(admin), params: updated_params

      expect(response).to redirect_to(admin_path(admin))
      follow_redirect!

      expect(response.body).to include(updated_params[:admin][:email])
    end

    it 'prevents an admin from updating another admin account' do
      login_as admin, scope: :admin

      patch administration_admin_path(superadmin), params: updated_params

      expect(response).to redirect_to root_path
      follow_redirect!

      expect(response.body).to include('You are not authorized to perform this action.')
    end

    it 'denies user access' do
      login_as current_user, scope: :user

      patch administration_admin_path(superadmin), params: updated_params

      expect(response).to redirect_to new_admin_session_path
    end
  end
end
