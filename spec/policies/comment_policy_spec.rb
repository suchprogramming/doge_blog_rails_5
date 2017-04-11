require 'rails_helper'

describe CommentPolicy do

  let(:user_post) { create(:current_user_post_comment) }

  def user
    user_post.postable
  end

  def user_comment
    user_post.comments.first
  end

  subject { CommentPolicy }

  permissions :new?, :create?, :edit?, :update?, :destroy? do
    it 'permits a user or admin to mutate a comment when params match' do
      expect(subject).to permit(user, user_comment)
    end

    it 'should not permit a user to mutate another user comment on any action' do
      expect(subject).not_to permit(User.new, user_comment)
    end

    it 'should not permit an inactive user to mutate comments' do
      user.update(active: false)

      expect(subject).not_to permit(user, user_comment)
    end
  end
end
