require 'rails_helper'

RSpec.describe 'Post management', :type => :request do

  let(:current_user_post) { create(:current_user_post) }
  let(:alternate_user_post) { create(:alternate_user_post) }

  def post_params
    { post: { title: 'test', post_content: 'test' } }
  end

  def current_user
    current_user_post.postable
  end

  def alternate_user
    alternate_user_post.postable
  end

  context 'on the POST #show route' do
    it 'allows an authenticated user to view any active post' do
      login_as current_user, scope: :user

      get user_post_path(alternate_user, alternate_user_post)

      expect(response).to be_success
    end

    # it 'renders the deactivated resource partial for inactive posts' do
    #   login_as current_user, scope: :user
    #
    #   current_user_post.update(active: false)
    #
    #   get user_post_path(current_user, current_user_post)
    #
    #   expect(response.body).to include('This resource has been deactivated, sorry!')
    # end
  end

  context 'on the POST #new route' do
    it 'grants access to a users new post route' do
      login_as current_user, scope: :user

      get new_user_post_path(current_user)

      expect(response).to be_success
    end

    it 'prevents the current user from accessing the new route of other users' do
      login_as current_user, scope: :user

      get new_user_post_path(alternate_user)

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end

    it 'prevents an inactive user from accessing the new post route' do
      login_as current_user, scope: :user

      current_user.update(active: false)

      get new_user_post_path(current_user)

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end
  end

  context 'on the POST #create route' do
    it 'allows the authenticated current user to create posts' do
      login_as current_user, scope: :user

      post user_posts_path(current_user), params: post_params
      follow_redirect!

      expect(response.body).to include('Your new post has been created!')
    end

    # post to other user route?

    it 'prevents an inactive user from creating a new post' do
      login_as current_user, scope: :user

      current_user.update(active: false)

      post user_posts_path(current_user), params: post_params

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end
  end

  context 'on the POST #edit route' do
    it 'allows the current user to edit their posts' do
      login_as current_user, scope: :user

      get edit_user_post_path(current_user, current_user_post)

      expect(response).to be_success
    end

    it 'prevents the current user from editing other user posts' do
      login_as current_user, scope: :user

      get edit_user_post_path(alternate_user, alternate_user_post)

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end

    it 'allows the current user to edit their inactive posts' do
      login_as current_user, scope: :user

      current_user_post.update(active: false)

      get edit_user_post_path(current_user, current_user_post)

      expect(response).to be_success
    end

    it 'prevents an inactive user from editing their posts' do
      login_as current_user, scope: :user

      current_user.update(active: false)

      get edit_user_post_path(current_user, current_user_post)

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end
  end

  context 'on the POST #update route' do
    it 'allows the authenticated current user to update their post' do
      login_as current_user, scope: :user

      patch user_post_path(current_user, current_user_post), params: post_params

      expect(response).to redirect_to(user_post_path(current_user, current_user_post))
      follow_redirect!

      expect(response.body).to include('Post successfully updated!')
    end

    it 'prevents the current user from updating other user posts' do
      login_as current_user, scope: :user

      patch user_post_path(alternate_user, alternate_user_post), params: post_params

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end

    it 'prevents an inactive user from updating their posts' do
      login_as current_user, scope: :user

      current_user.update(active: false)

      patch user_post_path(alternate_user, alternate_user_post), params: post_params

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end
  end

  context 'on the POST #delete route' do
    it 'allows the authenticated current user to delete their post' do
      login_as current_user, scope: :user

      delete user_post_path(current_user, current_user_post)

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include('Post successfully deleted!')
    end

    it 'prevents the current user from deleting other user posts' do
      login_as current_user, scope: :user

      delete user_post_path(alternate_user, alternate_user_post)

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end

    it 'prevents an inactive user from deleting a post' do
      login_as current_user, scope: :user

      current_user.update(active: false)

      delete user_post_path(current_user, current_user_post), params: post_params

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end
  end
end
