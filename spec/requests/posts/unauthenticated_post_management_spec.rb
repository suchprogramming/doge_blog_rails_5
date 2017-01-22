require 'rails_helper'

RSpec.describe 'Unauthenticated user post management', :type => :request do

  let(:user_post) { create(:post_with_user) }

  def user_post_owner
    user_post.postable
  end

  context 'on the POST #index route' do
    it 'allows public access to unauthenticated users' do
      get root_path

      expect(response).to be_success
    end
  end

  context 'on the POST #show route' do
    it 'allows public access to unauthenticated users' do
      get user_post_path(user_post_owner, user_post)

      expect(response).to be_success
    end

    it 'renders the deactivated resource partial for inactive posts' do
      user_post.update_attributes(active: false)

      get user_post_path(user_post_owner, user_post)

      expect(response.body).to include('This resource has been deactivated, sorry!')
    end
  end

  context 'on the POST #new route' do
    it 'redirects unauthenticated requests' do
      get '/users/1/posts/new'

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'on the POST #create route' do
    it 'redirects unauthenticated access' do
      post '/users/1/posts'

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'on the POST #edit route' do
    it 'redirects unauthenticated requests' do
      get '/users/1/posts/1/edit'

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'on the POST #update route' do
    it 'redirects unauthenticated requests' do
      patch '/users/1/posts/1'

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'on the POST #delete route' do
    it 'redirects unauthenticated requests' do
      delete '/users/1/posts/1'

      expect(response).to redirect_to(new_user_session_path)
    end
  end

end
