require 'rails_helper'

RSpec.describe 'Unauthenticated post management', :type => :request do

  let!(:user_post) { create(:current_user_post) }

  def user
    user_post.postable
  end

  def post_params
    { post: { title: 'test', post_content: 'test' } }
  end

  context 'on the POST #index route' do
    it 'allows public access to unauthenticated users' do
      get root_path

      expect(response).to be_success
      expect(response.body).to include(user_post.title)
    end
  end

  context 'on the POST #show route' do
    it 'allows public access to unauthenticated users' do
      get user_post_path(user, user_post)

      expect(response).to be_success
      expect(response.body).to include(user_post.title)
    end

    # it 'renders the deactivated resource partial for inactive posts' do
    #   user_post.update(active: false)
    #
    #   get user_post_path(user, user_post)
    #
    #   expect(response.body).to include('This resource has been deactivated, sorry!')
    # end
  end

  context 'on the POST #new route' do
    it 'redirects unauthenticated requests' do
      get new_user_post_path(user, user_post)

      expect(response).not_to be_success
      expect(response.status).to eq(401)
    end
  end

  context 'on the POST #create route' do
    it 'redirects unauthenticated access' do
      post user_posts_path(user), params: post_params

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'on the POST #edit route' do
    it 'redirects unauthenticated requests' do
      get edit_user_post_path(user, user_post)

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'on the POST #update route' do
    it 'redirects unauthenticated requests' do
      patch user_post_path(user, user_post)

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'on the POST #delete route' do
    it 'redirects unauthenticated requests' do
      delete user_post_path(user, user_post)

      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
