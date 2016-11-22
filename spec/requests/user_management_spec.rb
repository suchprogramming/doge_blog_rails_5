require "rails_helper"

RSpec.describe "User management", :type => :request do

  let(:current_user) { create(:user) }
  let(:second_user) { create(:user, email: "second_user@test.com") }
  let(:admin) { create(:admin) }

  context "on the USER #show route" do
    it "redirects unauthenticated requests" do
      get user_path(current_user)

      expect(response).to redirect_to(new_user_session_path)
    end

    it "allows the current_user to view their profile" do
      login_as current_user, scope: :user
      get user_path(current_user)

      expect(response).to be_success
    end

    it "allows the current_user to view any user profile" do
      login_as current_user, scope: :user
      get user_path(second_user)

      expect(response).to be_success
    end
  end

  context "on the USER #edit route" do
    it "redirects unauthenticated requests" do
      get edit_admin_manage_user_path(current_user)

      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects non admin users" do
      login_as current_user, scope: :user

      get edit_admin_manage_user_path(current_user)

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include("You are not authorized to perform this action.")
    end

    it "allows admin access" do
      login_as admin
      get edit_admin_manage_user_path(current_user)

      expect(response).to be_success
    end

  end

  context "on the USER #update route" do
    it "redirects unauthenticated requests" do
      patch "/admins/users/1", params: { email: "youshould@login.com" }

      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects non admin users" do
      login_as current_user
      patch "/admins/users/#{current_user.id}", params: { user: { email: "youshould@login.com" } }

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include("You are not authorized to perform this action.")
    end

    it "allows admins to edit user accounts" do
      login_as admin
      patch "/admins/users/#{current_user.id}", params: { user: { email: "updated@email.com" } }

      expect(response).to redirect_to(user_path(current_user))
      follow_redirect!

      expect(response.body).to include("User updated successfully!")
    end
  end
end
