require 'rails_helper'

RSpec.feature 'A user deletes a comment on a post', js: true do

  let(:user_post) { create(:current_user_post_comment) }

  def user
    user_post.postable
  end

  def comment
    user_post.comments.where(commentable_id: user.id).first
  end

  before(:each) do
    login_as user, scope: :user

    visit user_post_path(user, user_post)
  end

  scenario 'with success' do
    expect(page).not_to have_text('Are you sure you want to delete this comment?')

    find("#delete-comment-#{comment.id}").click

    expect(page).to have_text('Are you sure you want to delete this comment?')

    find('#delete-comment-modal-link').click

    expect(page).to have_text('Comment removed!')
  end

  scenario 'when canceling a comment delete' do
    expect(page).not_to have_text('Are you sure you want to delete this comment?')

    find("#delete-comment-#{comment.id}").click

    expect(page).to have_text('Are you sure you want to delete this comment?')

    find('a.modal-close').click

    expect(page).not_to have_text('Are you sure you want to delete this comment?')
  end

end
