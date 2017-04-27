require 'rails_helper'

describe CommentPolicy do

  subject { CommentPolicy }

  let(:user_comment) { Comment.new(commentable: User.new(id: 1)) }
  let(:admin_comment) { Comment.new(commentable: Admin.new(id: 1)) }

  def user
    user_comment.commentable
  end

  def admin
    admin_comment.commentable
  end

  permissions :new? do
    it 'permits a user or admin to access their new comment route' do
      expect(subject).to permit(user, user_comment)
      expect(subject).to permit(admin, admin_comment)
    end

    it 'prevents a user or admin from accessing the new route for other users' do
      expect(subject).not_to permit(user, admin_comment)
      expect(subject).not_to permit(admin, user_comment)
    end
  end

  permissions :create?, :edit?, :update?, :destroy? do
    it 'permits a user or admin to mutate a comment that they own' do
      expect(subject).to permit(user, user_comment)
      expect(subject).to permit(admin, admin_comment)
    end

    it 'should not permit a user or admin to mutate a comment they do not own' do
      expect(subject).not_to permit(User.new(id: 2), user_comment)
      expect(subject).not_to permit(Admin.new(id: 2), user_comment)
    end

    it 'should not permit an inactive user to mutate comments' do
      user.active = false

      expect(subject).not_to permit(user, user_comment)
    end

    it 'should not permit an inactive admin to mutate comments' do
      admin.active = false

      expect(subject).not_to permit(admin, user_comment)
    end
  end
end
