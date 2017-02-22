require 'rails_helper'

describe Administration::CommentPolicy do

  let(:user_post) { create(:current_user_post_comment) }
  let(:admin) { create(:admin) }

  def user
    user_post.postable
  end

  def user_comment
    user_post.comments.first
  end

  subject { Administration::CommentPolicy }

  permissions :update? do
    it 'permits an active admin to flag a comment' do
      expect(subject).to permit(admin, user_comment)
    end

    it 'should not permit an inactive admin to flag a comment' do
      admin.update(active: false)

      expect(subject).not_to permit(admin, user_comment)
    end

    it 'should not permit a user to flag a comment' do
      expect(subject).not_to permit(user, user_comment)
    end
  end

end
