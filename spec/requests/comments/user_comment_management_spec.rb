require 'rails_helper'

RSpec.describe 'User comment management', :type => :request do

  let(:current_user_post) { create(:current_user_post_comment) }
  let(:current_admin_post) { create(:current_admin_post_comment) }
  let(:alternate_user) { create(:alternate_user) }

  def comment_params
    { comment: { text: 'New Comment Testing' } }
  end

  def current_user
    current_user_post.postable
  end

  def user_comment
    current_user_post.comments.where(commentable_id: current_user.id).first
  end

  def current_admin
    current_admin_post.postable
  end

  def admin_comment
    current_admin_post.comments.where(commentable_id: current_admin.id).first
  end

  context 'on the COMMENT #new route' do
    it 'allows a user to instantiate a new comment if params match' do
      login_as current_user, scope: :user

      get new_user_post_comment_path(current_user, current_user_post), xhr: true

      expect(response).to be_success
    end

    it 'prevents a user from accessing the new comment route of other users' do
      login_as alternate_user, scope: :user

      get new_user_post_comment_path(current_user, current_user_post), xhr: true

      expect(response.body).to include(default_pundit_error)
    end

    it 'prevents a user from accessing the new comment route of admins' do
      login_as current_user, scope: :user

      get new_admin_post_comment_path(current_admin, current_admin_post), xhr: true

      expect(response.body).to include(default_pundit_error)
    end

    it 'prevents an inactive current user from accessing the new comment route' do
      login_as current_user, scope: :user

      current_user.update(active: false)

      get new_user_post_comment_path(current_user, current_user_post), xhr: true

      expect(response.body).to include(default_pundit_error)
    end
  end

  context 'on the COMMENT #create route' do
    it 'allows an active current user to create a comment on any post' do
      login_as current_user, scope: :user

      post user_post_comments_path(current_user, current_user_post),
           params: comment_params, xhr: true

      expect(response).to be_success
      expect(response.body).to include('Comment created!')
    end

    it 'prevents an inactive user from creating a comment' do
      login_as current_user, scope: :user

      current_user.update(active: false)

      post user_post_comments_path(current_user, current_user_post),
            params: comment_params, xhr: true

      expect(response.body).to include(default_pundit_error)
    end
  end

  context 'on the COMMENT #edit route' do
    it 'allows a user to edit their comment' do
      login_as current_user, scope: :user

      get edit_user_post_comment_path(current_user, current_user_post, user_comment), xhr: true

      expect(response).to be_success
    end

    it 'prevents users from editing other user comments' do
      login_as alternate_user, scope: :user

      get edit_user_post_comment_path(current_user, current_user_post, user_comment), xhr: true

      expect(response.body).to include(default_pundit_error)
    end

    it 'prevents users from editing admin comments' do
      login_as current_user, scope: :user

      get edit_admin_post_comment_path(current_admin, current_admin_post, admin_comment), xhr: true

      expect(response.body).to include(default_pundit_error)
    end

    it 'prevents inactive users from editing their comments' do
      login_as current_user, scope: :user

      current_user.update(active: false)

      get edit_user_post_comment_path(current_user, current_user_post, user_comment), xhr: true

      expect(response.body).to include(default_pundit_error)
    end
  end

  context 'on the COMMENT #update route' do
    it 'allows a user to update their comment' do
      login_as current_user, scope: :user

      patch user_post_comment_path(current_user, current_user_post, user_comment),
            params: { comment: { text: 'Updated!' } }, xhr: true

      expect(response).to be_success
      expect(response.body).to include('Comment updated!')
    end

    it 'prevents users from updating other user comments' do
      login_as alternate_user, scope: :user

      patch user_post_comment_path(current_user, current_user_post, user_comment),
            params: { comment: { text: 'Russia was here' } }, xhr: true

      expect(response.body).to include(default_pundit_error)
    end

    it 'prevents users from updating admin comments' do
      login_as current_user, scope: :user

      patch admin_post_comment_path(current_admin, current_admin_post, admin_comment),
            params: { comment: { text: 'Russia was here' } }, xhr: true

      expect(response.body).to include(default_pundit_error)
    end

    it 'prevents inactive users from updating comments' do
      login_as current_user, scope: :user

      current_user.update(active: false)

      patch user_post_comment_path(current_user, current_user_post, user_comment),
            params: { comment: { text: 'I got banned' } }, xhr: true

      expect(response.body).to include(default_pundit_error)
    end
  end

  context 'on the COMMENT #destroy route' do
    it 'allows a user to delete their comment' do
      login_as current_user, scope: :user

      delete user_post_comment_path(current_user, current_user_post, user_comment), xhr: true

      expect(response).to be_success
      expect(response.body).to include('Comment removed!')
    end

    it 'prevents a user from deleting other user comments' do
      login_as alternate_user, scope: :user

      delete user_post_comment_path(current_user, current_user_post, user_comment), xhr: true

      expect(response.body).to include(default_pundit_error)
    end

    it 'prevents a user from deleting admin comments' do
      login_as current_user, scope: :user

      delete admin_post_comment_path(current_admin, current_admin_post, admin_comment), xhr: true

      expect(response.body).to include(default_pundit_error)
    end

    it 'prevents inactive users from deleting comments' do
      login_as current_user, scope: :user

      current_user.update(active: false)

      delete user_post_comment_path(current_user, current_user_post, user_comment), xhr: true

      expect(response.body).to include(default_pundit_error)
    end
  end
end
