require 'rails_helper'

RSpec.feature 'An admin flags a comment', js: true do

  let(:user_post) { create(:current_user_post_comment) }
  let(:admin) { create(:admin) }

  def user
    user_post.postable
  end

  def comment
    user_post.comments.where(commentable_id: user.id).first
  end

  before(:each) do
    login_as admin, scope: :admin
  end

  scenario 'with success' do
    visit user_post_path(user, user_post)

    find("#flag-comment-check-#{comment.id}").click

    wait_for_ajax

    expect(page).to have_text('Comment flagged!')
  end

  scenario 'when activating a flagged comment with success' do
    comment.update(flagged: true)

    visit user_post_path(user, user_post)

    find("#flag-comment-check-#{comment.id}").click

    wait_for_ajax

    expect(page).to have_text('Comment activated!')
  end
end
