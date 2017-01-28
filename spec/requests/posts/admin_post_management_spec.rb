require 'rails_helper'

RSpec.describe 'Admin post managment', :type => :request do

  let(:current_admin_post) { create(:current_admin_post) }
  let(:alternate_admin_post) { create(:alternate_admin_post) }
  let(:user_post) { create(:post_with_user) }

  def post_params
    { post: { title: 'test', post_content: 'test' } }
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

  context 'on the POST #show route' do
    it 'allows an active admin to view any post on the show route' do
      login_as current_admin, scope: :admin

      get user_post_path(user_post_owner, user_post)

      expect(response).to be_success
    end

    it 'allows an active admin to view an inactive post' do
      login_as current_admin, scope: :admin

      user_post.update(active: false)

      get user_post_path(user_post_owner, user_post)

      expect(response).to be_success
    end

    it 'prevents an inactive admin from viewing an inactive post' do
      login_as current_admin, scope: :admin

      current_admin.update(active: false)
      user_post.update(active: false)

      get user_post_path(user_post_owner, user_post)

      expect(response.body).to include('This resource has been deactivated, sorry!')
    end
  end

  context 'on the POST #new route' do
    it 'allows an admin to access the new admin post route' do
      login_as current_admin, scope: :admin

      get new_admin_post_path(current_admin)

      expect(response).to be_success
    end

    it 'prevents an admin from accessing a users new post route' do
      login_as current_admin, scope: :admin

      get new_user_post_path(user_post_owner)

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end

    it 'prevents an inactive admin from accessing the new post route' do
      login_as current_admin, scope: :admin

      current_admin.update(active: false)

      get new_admin_post_path(current_admin)

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end
  end

  context 'on the POST #create route' do
    it 'allows the authenticated admin to create posts' do
      login_as current_admin, scope: :admin

      post admin_posts_path(current_admin), params: post_params
      follow_redirect!

      expect(response.body).to include('Your new post has been created!')
    end

    # post to user route?

    it 'prevents an inactive admin from creating posts' do
      login_as current_admin, scope: :admin

      current_admin.update(active: false)

      post admin_posts_path(current_admin), params: post_params

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end
  end

  context 'on the POST #edit route' do
    it 'allows an admin to access the edit route for any post' do
      login_as current_admin, scope: :admin

      get edit_user_post_path(user_post_owner, user_post)

      expect(response).to be_success
    end

    it 'allows an admin to edit an inactive post' do
      login_as current_admin, scope: :admin

      user_post.update(active: false)

      get edit_user_post_path(user_post_owner, user_post)

      expect(response).to be_success
    end

    it 'prevents an inactive admin from editing posts' do
      login_as current_admin, scope: :admin

      current_admin.update(active: false)

      get edit_user_post_path(user_post_owner, user_post)

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end
  end

  context 'on the POST #update route' do
    it 'allows an admin to update any post' do
      login_as current_admin, scope: :admin

      patch user_post_path(user_post_owner, user_post), params: post_params

      expect(response).to redirect_to(user_post_path(user_post_owner, user_post))
      follow_redirect!

      expect(response.body).to include('Post successfully updated!')
    end

    it 'prevents an inactive admin from updating posts' do
      login_as current_admin, scope: :admin

      current_admin.update(active: false)

      patch admin_post_path(current_admin, current_admin_post), params: post_params

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end
  end

  context 'on the POST #delete route' do
    it 'allows an admin to delete any post' do
      login_as current_admin, scope: :admin

      delete user_post_path(user_post_owner, user_post)

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include('Post successfully deleted!')
    end

    it 'prevents an inactive admin from deleting posts' do
      login_as current_admin, scope: :admin

      current_admin.update(active: false)

      delete admin_post_path(current_admin, current_admin_post)

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end
  end

end
