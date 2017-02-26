require 'rails_helper'

RSpec.describe 'Admin comment management', :type => :request do

  let(:current_user_post) { create(:current_user_post_comment) }
  let(:current_admin_post) { create(:current_admin_post_comment) }
  let(:alternate_admin) { create(:alternate_admin, email: 'admin@comments.com') }

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
    it 'allows an admin to instantiate a new comment if params match' do
      login_as current_admin, scope: :admin

      get new_admin_post_comment_path(current_admin, current_admin_post), xhr: true

      expect(response).to be_success
    end

    it 'prevents an admin from accessing the new comment route of other admins' do
      login_as alternate_admin, scope: :admin

      get new_admin_post_comment_path(current_admin, current_admin_post), xhr: true

      expect(response.body).to include(default_pundit_error)
    end

    it 'prevents an admin from accessing the new comment route of other users' do
      login_as alternate_admin, scope: :admin

      get new_user_post_comment_path(current_user, current_user_post), xhr: true

      expect(response.body).to include(default_pundit_error)
    end

    it 'prevents an inactive current admin from accessing the new comment route' do
      login_as current_admin, scope: :admin

      current_admin.update(active: false)

      get new_admin_post_comment_path(current_admin, current_admin_post), xhr: true

      expect(response.body).to include(default_pundit_error)
    end
  end

  context 'on the COMMENT #create route' do
    it 'allows an active current admin to create a comment on any post' do
      login_as current_admin, scope: :admin

      post admin_post_comments_path(current_admin, current_admin_post),
           params: comment_params, xhr: true

      expect(response).to be_success
      expect(response.body).to include('Comment created!')
    end

    it 'prevents an inactive admin from creating a comment' do
      login_as current_admin, scope: :admin

      current_admin.update(active: false)

      post admin_post_comments_path(current_admin, current_admin_post),
            params: comment_params, xhr: true

      expect(response.body).to include(default_pundit_error)
    end
  end

  context 'on the COMMENT #edit route' do
    it 'allows an admin to edit their comment' do
      login_as current_admin, scope: :admin

      get edit_admin_post_comment_path(current_admin, current_admin_post, admin_comment), xhr: true

      expect(response).to be_success
    end

    it 'prevents admins from editing other admin comments' do
      login_as alternate_admin, scope: :admin

      get edit_admin_post_comment_path(current_admin, current_admin_post, admin_comment), xhr: true

      expect(response.body).to include(default_pundit_error)
    end

    it 'prevents admins from editing other user comments' do
      login_as current_admin, scope: :admin

      get edit_user_post_comment_path(current_user, current_user_post, user_comment), xhr: true

      expect(response.body).to include(default_pundit_error)
    end

    it 'prevents inactive admins from editing their comments' do
      login_as current_admin, scope: :admin

      current_admin.update(active: false)

      get edit_admin_post_comment_path(current_admin, current_admin_post, admin_comment), xhr: true

      expect(response.body).to include(default_pundit_error)
    end
  end

  context 'on the COMMENT #update route' do
    it 'allows an admin to update their comment' do
      login_as current_admin, scope: :admin

      patch admin_post_comment_path(current_admin, current_admin_post, admin_comment),
            params: { comment: { text: 'Updated!' } }, xhr: true

      expect(response).to be_success
      expect(response.body).to include('Comment updated!')
    end

    it 'prevents admins from updating other admin comments' do
      login_as alternate_admin, scope: :admin

      patch admin_post_comment_path(current_admin, current_admin_post, admin_comment),
            params: { comment: { text: 'Russia was here' } }, xhr: true

      expect(response.body).to include(default_pundit_error)
    end

    it 'prevents inactive admins from updating comments' do
      login_as current_admin, scope: :admin

      current_admin.update(active: false)

      patch admin_post_comment_path(current_admin, current_admin_post, admin_comment),
            params: { comment: { text: 'I got banned' } }, xhr: true

      expect(response.body).to include(default_pundit_error)
    end
  end

  context 'on the COMMENT #destroy route' do
    it 'allows an admin to delete their comment' do
      login_as current_admin, scope: :admin

      delete admin_post_comment_path(current_admin, current_admin_post, admin_comment), xhr: true

      expect(response).to be_success
      expect(response.body).to include('Comment removed!')
    end

    it 'prevents an admin from deleting other admin comments' do
      login_as alternate_admin, scope: :admin

      delete admin_post_comment_path(current_admin, current_admin_post, admin_comment), xhr: true

      expect(response.body).to include(default_pundit_error)
    end

    it 'prevents an admin from deleting other user comments' do
      login_as current_admin, scope: :admin

      delete user_post_comment_path(current_user, current_user_post, user_comment), xhr: true

      expect(response.body).to include(default_pundit_error)
    end

    it 'prevents inactive admins from deleting comments' do
      login_as current_admin, scope: :admin

      current_admin.update(active: false)

      delete admin_post_comment_path(current_admin, current_admin_post, admin_comment), xhr: true

      expect(response.body).to include(default_pundit_error)
    end
  end

  context 'on the ADMINISTRATION::COMMENT #update route' do
    it 'allows an admin to flag an inappropriate comment' do
      login_as current_admin, scope: :admin

      patch administration_comment_path(user_comment),
            params: {
              comment: { flagged: '1' },
              user_id: current_user.id, post_id: current_user_post.id
            }, xhr: true

      expect(response).to be_success
      expect(response.body).to include('Comment flagged!')
    end

    it 'allows an admin to activate a previously flagged comment' do
      login_as current_admin, scope: :admin

      user_comment.update(flagged: true)

      patch administration_comment_path(user_comment),
            params: {
              comment: { flagged: '0' },
              user_id: current_user.id, post_id: current_user_post.id
            }, xhr: true

      expect(response).to be_success
      expect(response.body).to include('Comment activated!')
    end

    it 'prevents params other than flagged from being updated' do
      login_as current_admin, scope: :admin

      patch administration_comment_path(user_comment),
            params: {
              comment: { flagged: '1' , text: 'Russia gets you again!' },
              user_id: current_user.id, post_id: current_user_post.id
            }, xhr: true

      expect(response).to be_success
      expect(user_comment.text).to eq('I agree!')
      expect(response.body).to include('Comment flagged!')
    end

    it 'prevents inactive admins from flagging comments' do
      login_as current_admin, scope: :admin

      current_admin.update(active: false)

      patch administration_comment_path(user_comment),
            params: {
              comment: { flagged: '1' },
              user_id: current_user.id, post_id: current_user_post.id
            }, xhr: true

      expect(response.body).to include(default_pundit_error)
    end
  end

end
