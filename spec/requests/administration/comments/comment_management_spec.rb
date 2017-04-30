require 'rails_helper'

RSpec.describe 'Administration comment management', :type => :request do

  let(:admin) { create(:admin) }
  let(:current_user_post) { create(:current_user_post_comment) }

  def flagged_params
    { comment: { text: 'New Comment Testing' } }
  end

  def current_user
    current_user_post.postable
  end

  def user_comment
    current_user_post.comments.where(commentable_id: current_user.id).first
  end

  context 'on the COMMENT #update route' do
    it 'allows an admin to flag an inappropriate comment' do
      login_as admin, scope: :admin

      patch administration_comment_path(user_comment),
            params: { comment: { flagged: '1' } }, xhr: true,
            headers: { "HTTP_REFERER" => "http://example.com/" }

      expect(response).to be_success
      expect(response.body).to include('Comment flagged!')
    end

    it 'allows an admin to activate a previously flagged comment' do
      login_as admin, scope: :admin

      user_comment.update(flagged: true)

      patch administration_comment_path(user_comment),
            params: { comment: { flagged: '0' } }, xhr: true,
            headers: { "HTTP_REFERER" => "http://example.com/" }

      expect(response).to be_success
      expect(response.body).to include('Comment activated!')
    end

    it 'prevents params other than flagged from being updated' do
      login_as admin, scope: :admin

      user_comment.update(flagged: true)

      patch administration_comment_path(user_comment),
            params: { comment: { flagged: '0' , text: 'Russia gets you again!' } }, xhr: true,
            headers: { "HTTP_REFERER" => "http://example.com/" }

      expect(response).to be_success
      expect(response.body).to include(user_comment.text)
      expect(response.body).to include('Comment activated!')
    end

    it 'prevents inactive admins from flagging comments' do
      login_as admin, scope: :admin

      admin.update(active: false)

      patch administration_comment_path(user_comment),
            params: { comment: { flagged: '1' } }, xhr: true,
            headers: { "HTTP_REFERER" => "http://example.com/" }

      expect(response.body).to include(default_pundit_error)
    end
  end
end
