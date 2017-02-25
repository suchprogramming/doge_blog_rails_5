require 'rails_helper'

RSpec.feature 'A user edits a comment on a post', js: true do

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

    expect(user_post.comments.size).to eq(2)
    expect(all('.edit-comment-link').size).to eq(1)
  end

  scenario 'with success' do
    find("#edit-comment-#{comment.id}").click

    expect(page).to have_selector("#edit_comment_#{comment.id}")
    expect(page).to have_text(comment.text)

    fill_in 'comment_text', with: 'Updated Text'
    click_on 'Submit'

    expect(page).to have_text('Comment updated!')
    expect(page).to have_text('Updated Text')
  end

  scenario 'with validation errors' do
    find("#edit-comment-#{comment.id}").click

    expect(page).to have_selector("#edit_comment_#{comment.id}")
    expect(page).to have_text(comment.text)

    fill_in 'comment_text', with: ''
    click_on 'Submit'

    expect(page).to have_text("can't be blank")
  end

  scenario 'when canceling a comment edit' do
    find("#edit-comment-#{comment.id}").click

    expect(page).to have_selector("#edit_comment_#{comment.id}")
    expect(page).to have_text(comment.text)

    find('#cancel-comment').click

    expect(page).not_to have_selector('#new_comment')
  end

  scenario 'when clicking edit comment multiple times' do
    find("#edit-comment-#{comment.id}").click

    wait_for_ajax

    find("#edit-comment-#{comment.id}").click

    expect(all("#edit-comment-#{comment.id}").length).to eq(1)
  end
end
