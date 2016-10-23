require "rails_helper"

RSpec.describe "Post management", :type => :request do

  let(:current_user) { create(:user) }
  let(:second_user) { create(:user, email: "second_user@test.com") }
  let(:admin) { create(:admin) }

  context "on the POST #index route" do
    it "allows public access to unauthenticated users" do
      get root_path

      expect(response).to be_success
    end
  end

  context "on the POST #show route" do
    it "allows public access to unauthenticated users" do
      post = create(:post)
      get user_post_path(post.postable, post)

      expect(response).to be_success
    end
  end

  context "on the POST #new route" do
    it "redirects unauthenticated requests" do
      get "/users/1/posts/new"

      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects unauthorized user access" do
      login_as current_user, scope: :user

      get new_user_post_path(second_user)

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include("You are not authorized to perform this action.")
    end

    it "redirects unauthorized admin access" do
      login_as admin

      get new_user_post_path(second_user)

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include("You are not authorized to perform this action.")
    end

    it "allows the authenticated current_user access the new route" do
      login_as current_user, scope: :user

      get new_user_post_path(current_user)

      expect(response).to be_success
    end

    it "allows an admin to access the new route" do
      login_as admin
      get new_admin_post_path(admin)

      expect(response).to be_success
    end
  end

  context "on the POST #create route" do
    it "redirects unauthenticated access" do
      post "/users/1/posts"

      expect(response).to redirect_to(new_user_session_path)
    end

    it "allows the authenticated current user to create posts" do
      login_as current_user, scope: :user

      post user_posts_path(current_user), params: { post: { title: "test", post_content: "test" } }
      follow_redirect!

      expect(response.body).to include("Your new post has been created!")
    end

    it "allows the authenticated admin to create posts" do
      login_as admin

      post admin_posts_path(admin), params: { post: { title: "test", post_content: "test" } }
      follow_redirect!

      expect(response.body).to include("Your new post has been created!")
    end
  end

  context "on the POST #edit route" do
    it "redirects unauthenticated requests" do
      get "/users/1/posts/1/edit"

      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects unauthorized requests" do
      login_as current_user, scope: :user
      post = create(:post, postable: second_user)

      get edit_user_post_path(second_user, post)

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include("You are not authorized to perform this action.")
    end

    it "allows the authenticated current_user access to their post on the edit route" do
      login_as current_user, scope: :user
      post = create(:post, postable: current_user)

      get edit_user_post_path(current_user, post)

      expect(response).to be_success
    end

    it "allows an admin to access the edit route for any post" do
      login_as admin
      post = create(:post, postable: current_user)

      get edit_user_post_path(post.postable, post)

      expect(response).to be_success
    end
  end

  context "on the POST #update route" do
    it "redirects unauthenticated requests" do
      patch "/users/1/posts/1"

      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects unauthorized requests" do
      login_as current_user, scope: :user
      post = create(:post, postable: second_user)

      patch user_post_path(current_user, post), params: { post: { title: "test", post_content: "test" } }

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include("You are not authorized to perform this action.")
    end

    it "allows the authenticated current_user to update their post" do
      login_as current_user, scope: :user
      post = create(:post, postable: current_user)

      patch user_post_path(current_user, post), params: { post: { title: "test", post_content: "test" } }

      expect(response).to redirect_to(user_post_path(current_user, post))
      follow_redirect!

      expect(response.body).to include("Post successfully updated!")
    end

    it "allows an admin to edit any users post" do
      login_as admin
      post = create(:post)

      patch user_post_path(post.postable, post), params: { post: { title: "test", post_content: "test" } }

      expect(response).to redirect_to(user_post_path(post.postable, post))
      follow_redirect!

      expect(response.body).to include("Post successfully updated!")
    end
  end

  context "on the POST #delete route" do
    it "redirects unauthenticated requests" do
      delete "/users/1/posts/1"

      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects unauthorized requests" do
      login_as current_user, scope: :user
      post = create(:post, postable: second_user)

      delete user_post_path(current_user, post)

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include("You are not authorized to perform this action.")
    end

    it "allows the authenticated current_user to delete their post" do
      login_as current_user, scope: :user
      post = create(:post, postable: current_user)

      delete user_post_path(current_user, post)

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include("Post successfully deleted!")
    end

    it "allows an admin to delete any users post" do
      login_as admin
      post = create(:post)

      delete user_post_path(post.postable, post)

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include("Post successfully deleted!")
    end
  end

end
