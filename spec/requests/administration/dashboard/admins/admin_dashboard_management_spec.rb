require 'rails_helper'

RSpec.describe 'Admin dashboard management', :type => :request do

  let(:admin) { create(:admin) }

  before(:each) do
    login_as admin, scope: :admin
  end

  context 'on the DASHBOARD #posts route' do
    it 'grants active admin access' do
      get administration_dashboard_posts_path

      expect(response).to be_success
    end

    it 'rejects inactive admin access' do
      admin.update(active: false)

      get administration_dashboard_posts_path

      expect(response).to redirect_to(root_path)
    end
  end

  context 'on the DASHBOARD #users route' do
    it 'grants active admin access' do
      get administration_dashboard_users_path

      expect(response).to be_success
    end

    it 'rejects inactive admin access' do
      admin.update(active: false)

      get administration_dashboard_users_path

      expect(response).to redirect_to(root_path)
    end
  end

  context 'on the DASHBOARD #comments route' do
    it 'grants active admin access' do
      get administration_dashboard_comments_path

      expect(response).to be_success
    end

    it 'rejects inactive admin access' do
      admin.update(active: false)

      get administration_dashboard_comments_path

      expect(response).to redirect_to(root_path)
    end
  end

  context 'on the DASHBOARD #admins route' do
    it 'rejects admin access' do
      get administration_dashboard_admins_path

      expect(response).to redirect_to(root_path)
    end
  end

  context 'on the DASHBOARD #invitations route' do
    it 'rejects admin access' do
      get administration_dashboard_invitations_path

      expect(response).to redirect_to(root_path)
    end
  end
end
