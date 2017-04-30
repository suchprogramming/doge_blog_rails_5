require 'rails_helper'

RSpec.describe 'Administration post management', :type => :request do

  let(:current_user_post) { create(:current_user_post) }
  let(:admin) { create(:admin) }

  def user
    current_user_post.postable
  end

  context 'on the POST #update route' do
    it 'allows an active admin to deactivate a post' do
      login_as admin, scope: :admin

      patch administration_post_path(current_user_post),
            params: { post: { active: '0' } }, xhr: true

      expect(response).to be_success
      expect(response.body).to include('Post deactivated!')
    end

    it 'allows an active admin to activate a post' do
      current_user_post.update(active: false)

      login_as admin, scope: :admin

      patch administration_post_path(current_user_post),
            params: { post: { active: '1' } }, xhr: true

      expect(response).to be_success
      expect(response.body).to include('Post activated!')
    end

    it 'prevents an inactive admin from deactivating posts' do
      admin.update(active: false)

      login_as admin, scope: :admin

      patch administration_post_path(current_user_post),
            params: { post: { active: '0' } }, xhr: true

      expect(response.body).to include default_pundit_error
    end

    it 'prevents users from mutating post status' do
      login_as user, scope: :user

      patch administration_post_path(current_user_post),
            params: { post: { active: '0' } }, xhr: true

      expect(response.status).to eq(401)
    end
  end
end
