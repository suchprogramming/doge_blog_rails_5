require 'rails_helper'

RSpec.describe 'Unauthenticated comment management', :type => :request do

  def comment_params
    { comment: { text: 'New Comment Testing' } }
  end

  context 'on the COMMENT #new route' do
    it 'returns 401 unauthorized on unauthenticated requests' do
      get new_user_post_comment_path(User.new(id: 1), Post.new(id: 1)), xhr: true

      expect(response.status).to eq(401)
    end
  end

  context 'on the COMMENT #create route' do
    it 'returns 401 unauthorized on unauthenticated requests' do
      post user_post_comments_path(User.new(id: 1), Post.new(id: 1)),
           params: comment_params, xhr: true

      expect(response.status).to eq(401)
    end
  end

  context 'on the COMMENT #edit route' do
    it 'returns 401 unauthorized on unauthenticated requests' do
      get edit_user_post_comment_path(User.new(id: 1), Post.new(id: 1), Comment.new(id: 1)), xhr: true

      expect(response.status).to eq(401)
    end
  end

  context 'on the COMMENT #update route' do
    it 'returns 401 unauthorized on unauthenticated requests' do
      patch user_post_comment_path(User.new(id: 1), Post.new(id: 1), Comment.new(id: 1)),
            params: comment_params, xhr: true

      expect(response.status).to eq(401)
    end
  end

  context 'on the COMMENT #destroy route' do
    it 'returns 401 unauthorized on unauthenticated requests' do
      delete admin_post_comment_path(User.new(id: 1), Post.new(id: 1), Comment.new(id: 1)), xhr: true

      expect(response.status).to eq(401)
    end
  end
end
