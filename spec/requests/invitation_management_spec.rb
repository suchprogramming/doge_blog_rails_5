require "rails_helper"

RSpec.describe "Superadmin invitation management", :type => :request do

  let(:admin) { create(:admin) }
  let(:superadmin_invitation) { create(:superadmin_invitation) }

  def super_admin
    superadmin_invitation.admin
  end

  def invite_params
    { invitation: { recipient_email: 'thedoge@doge.com'} }
  end

  context 'on the INVITATION #index route' do
    it 'allows an admin to view a list of invitations' do
      login_as admin

      get superadmins_invitations_path

      expect(response).to be_success
    end

    it 'allows a superadmin to view a list of invitations' do
      login_as super_admin

      get superadmins_invitations_path

      expect(response).to be_success
    end
  end

  context 'on the INVITATION #new route' do
    it 'grants a superadmin access to the new invitation route' do
      login_as super_admin

      get new_superadmins_invitation_path

      expect(response).to be_success
    end

    it 'denies regular admin access to the new invitation route' do
      login_as admin

      get new_superadmins_invitation_path

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include('You are not authorized to perform this action.')
    end
  end

  context 'on the INVITATION #create route' do
    it 'allows a superadmin to create a new invitation' do
      login_as super_admin

      post superadmins_invitations_path, params: invite_params
      follow_redirect!

      expect(response.body).to include('Invite created!')
    end

    it 'prevents a regular admin from creating invites' do
      login_as admin

      post superadmins_invitations_path, params: invite_params
      follow_redirect!

      expect(response.body).to include('You are not authorized to perform this action.')
    end

    it 'deactivates all invites for a recipient email before creation' do
      old_invite = superadmin_invitation
      login_as super_admin

      post superadmins_invitations_path, params: invite_params
      follow_redirect!

      expect(response.body).to include('Invite created!')
      expect(Invitation.active_user_invites('thedoge@doge.com').count).to eq(1)
    end
  end
end
