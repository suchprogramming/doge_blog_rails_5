require 'rails_helper'

RSpec.feature 'Edit links for other posts are not rendered', js: true do

  let(:user_post) { create(:current_user_post_comment) }

  def user
    user_post.postable
  end

  def user_comment
    user_post.comments.where(commentable_id: user.id).first
  end

  def alternate_comment
    user_post.comments.reject { |c| c.commentable_id == user.id }.first
  end

  before(:each) do
    login_as user, scope: :user

    visit user_post_path(user, user_post)
  end

  scenario 'with success' do
    expect(user_post.comments.size).to eq(3)
    expect(all('.edit-comment-link').size).to eq(1)
    expect(page).to have_selector('a', id: "edit-comment-#{user_comment.id}")
    expect(page).not_to have_selector('a', id: "edit-comment-#{alternate_comment.id}")
  end
end
