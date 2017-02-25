require 'rails_helper'

RSpec.feature 'A admin deletes a comment on a post', js: true do

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
    expect(page).not_to have_text('Are you sure you want to delete this comment?')

    find("#delete-comment-#{comment.id}").click

    expect(page).to have_text('Are you sure you want to delete this comment?')

    find('#delete-comment-link-modal').click

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
