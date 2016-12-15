require "rails_helper"

RSpec.describe "Admin post managment", :type => :request do

  let(:current_admin_post) { create(:current_admin_post) }
  let(:alternate_admin_post) { create(:alternate_admin_post) }
  let(:user_post) { create(:post_with_user) }

  def post_params
    { post: { title: "test", post_content: "test" } }
  end

  def current_admin
    current_admin_post.postable
  end

  def alternate_admin
    alternate_admin_post.postable
  end

  def user_post_owner
    user_post.postable
  end

  context "on the POST #show route" do
    it "allows an admin to view any user post on the show route" do
      login_as current_admin

      get user_post_path(user_post_owner, user_post)

      expect(response).to be_success
    end

    it "allows an admin to view any admin post on the show route" do
      login_as current_admin

      get admin_post_path(alternate_admin, alternate_admin_post)

      expect(response).to be_success
    end

    it "allows an admin to view an inactive post" do
      login_as current_admin

      user_post.update_attributes(active: false)

      get user_post_path(user_post_owner, user_post)

      expect(response).to be_success
    end
  end

  context "on the POST #new route" do
    it "redirects when an admin attempts to access a users new post route" do
      login_as current_admin

      get new_user_post_path(user_post_owner)

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include("You are not authorized to perform this action.")
    end

    it "allows an admin to access the new admin post route" do
      login_as current_admin

      get new_admin_post_path(current_admin)

      expect(response).to be_success
    end
  end

  context "on the POST #create route" do
    it "allows the authenticated admin to create posts" do
      login_as current_admin

      post admin_posts_path(current_admin), params: post_params
      follow_redirect!

      expect(response.body).to include("Your new post has been created!")
    end
  end

  context "on the POST #edit route" do
    it "allows an admin to access the edit route for any user post" do
      login_as current_admin

      get edit_user_post_path(user_post_owner, user_post)

      expect(response).to be_success
    end

    it "allows an admin to access the edit route for any admin post" do
      login_as current_admin

      get edit_admin_post_path(alternate_admin, alternate_admin_post)

      expect(response).to be_success
    end

    it "allows an admin to edit an inactive post" do
      login_as current_admin

      user_post.update_attributes(active: false)

      get edit_user_post_path(user_post_owner, user_post)

      expect(response).to be_success
    end
  end

  context "on the POST #update route" do
    it "allows an admin to update any user post" do
      login_as current_admin

      patch user_post_path(user_post_owner, user_post), params: post_params

      expect(response).to redirect_to(user_post_path(user_post_owner, user_post))
      follow_redirect!

      expect(response.body).to include("Post successfully updated!")
    end

    it "allows an admin to update any admin post" do
      login_as current_admin

      patch admin_post_path(alternate_admin, alternate_admin_post), params: post_params

      expect(response).to redirect_to(admin_post_path(alternate_admin, alternate_admin_post))
      follow_redirect!

      expect(response.body).to include("Post successfully updated!")
    end
  end

  context "on the POST #delete route" do
    it "allows an admin to delete any users post" do
      login_as current_admin

      delete user_post_path(user_post_owner, user_post)

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include("Post successfully deleted!")
    end

    it "allows an admin to delete any admin post" do
      login_as current_admin

      delete admin_post_path(alternate_admin, alternate_admin_post)

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include("Post successfully deleted!")
    end
  end

end
