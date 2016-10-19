require "rails_helper"

RSpec.describe "User management", :type => :request do

  let(:current_user) { create(:user) }
  let(:second_user) { create(:user, email: "second_user@test.com") }

  context "on the USER #show route" do
    it "redirects unauthenticated requests" do
      get "/users/1"

      expect(response).to redirect_to(new_user_session_path)
    end

    it "allows the current_user to view their profile" do
      login_as current_user
      get user_path(current_user)

      expect(response).to be_success
    end

    it "allows the current_user to view any user profile" do
      login_as current_user
      get user_path(second_user)

      expect(response).to be_success
    end
  end
end
