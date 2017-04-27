require 'rails_helper'

RSpec.describe 'Vote management', :type => :request do

  let(:user_post) { create(:current_user_post) }
  let(:admin) { create(:admin) }
  let(:super_admin) { create(:super_admin) }

  def user
    user_post.postable
  end

  def vote_params
    {
      vote: { direction: 'up' },
      user_id: user.id,
      post_id: user_post.id
    }
  end

  context 'on the VOTE #create route' do
    it 'allows a user to create a vote with correct params' do
      login_as user, scope: :user

      post votes_path, xhr: true, params: vote_params

      expect(response).to be_success
      expect(response.body).to include("active-up")
    end

    it 'responds with an unauthorized error when params are mismatched' do
      login_as user, scope: :user

      post votes_path, xhr: true, params: vote_params.merge(user_id: 999)

      expect(response.body).to include(default_pundit_error)
    end

    it 'responds with an unauthorized error when a user is inactive' do
      login_as user, scope: :user

      user.update(active: false)

      post votes_path, xhr: true, params: vote_params

      expect(response.body).to include(default_pundit_error)
    end

    it 'responds with 401 unauthorized for admins' do
      login_as admin, scope: :admin

      post votes_path, xhr: true, params: vote_params

      expect(response.status).to eq(401)
    end

    it 'responds with 401 unauthorized super admins' do
      login_as super_admin, scope: :admin

      post votes_path, xhr: true, params: vote_params

      expect(response.status).to eq(401)
    end

    it 'responds with 401 unauthorized for unauthenticated requests' do
      post votes_path, xhr: true, params: vote_params

      expect(response.status).to eq(401)
    end
  end
end
