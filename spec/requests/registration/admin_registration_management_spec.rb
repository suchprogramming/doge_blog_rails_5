require 'rails_helper'

RSpec.describe 'Admin registration management', :type => :request do

  let!(:invitation) { create(:invitation) }

  def valid_params
    {
      admin: {
        email: invitation.recipient_email,
        password: 123456,
        password_confirmation: 123456,
        token: invitation.token
      }
    }
  end

  def invalid_params
    {
      admin: {
        email: 'issue-1-WRONG!',
        password: 1,
        password_confirmation: 2,
        token: 'bob-ross-let-me-in'
      }
    }
  end

  context 'on the REGISTRATION #new route' do
    it 'grants access with a valid token' do
      get administration_path(invitation.token)

      expect(response).to be_success
      expect(response.body).to include('New Admin Creation')
    end

    it 'redirects requests with invalid tokens' do
      get administration_path('russia-stole-your-token')

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end

    it 'redirects requests with expired tokens' do
      invitation.update_attributes(expires_at: 1.week.ago)

      get administration_path(invitation.token)

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end
  end

  context 'on the REGISTRATION #create route' do
    it 'allows for admin creation with valid invite credentials' do
      post administration_registrations_path, params: valid_params

      expect(response).to redirect_to(administration_dashboard_path)
      follow_redirect!

      expect(response.body).to include('Welcome to the team!')
    end

    it 'rejects creation if invite credentials are incorrect' do
      post administration_registrations_path, params: invalid_params

      expect(response.body).to include('Invalid invitation credentials')
    end
  end

end
