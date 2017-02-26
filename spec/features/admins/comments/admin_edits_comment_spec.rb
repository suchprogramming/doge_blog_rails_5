require 'rails_helper'

RSpec.feature 'An admin edits a comment on a post', js: true do

  let(:admin_post) { create(:current_admin_post_comment) }

  def admin
    admin_post.postable
  end

  def comment
    admin_post.comments.where(commentable_id: admin.id).first
  end

  before(:each) do
    login_as admin, scope: :admin

    visit admin_post_path(admin, admin_post)
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

    find("#edit-comment-#{comment.id}").click

    expect(all("#edit-comment-#{comment.id}").length).to eq(1)
  end
end
