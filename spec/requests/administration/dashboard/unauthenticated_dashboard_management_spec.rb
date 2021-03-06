require 'rails_helper'

RSpec.describe 'Unauthenticated dashboard management', :type => :request do

  context 'on the DASHBOARD #posts route' do
    it 'rejects unauthenticated access' do
      get administration_dashboard_posts_path

      expect(response).to redirect_to new_admin_session_path
    end
  end

  context 'on the DASHBOARD #users route' do
    it 'rejects unauthenticated access' do
      get administration_dashboard_users_path

      expect(response).to redirect_to new_admin_session_path
    end
  end

  context 'on the DASHBOARD #comments route' do
    it 'rejects unauthenticated access' do
      get administration_dashboard_comments_path

      expect(response).to redirect_to new_admin_session_path
    end
  end

  context 'on the DASHBOARD #comments route' do
    it 'rejects unauthenticated access' do
      get administration_dashboard_admins_path

      expect(response).to redirect_to new_admin_session_path
    end
  end

  context 'on the DASHBOARD #comments route' do
    it 'rejects unauthenticated access' do
      get administration_dashboard_invitations_path

      expect(response).to redirect_to new_admin_session_path
    end
  end
end
