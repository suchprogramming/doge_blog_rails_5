require 'rails_helper'

RSpec.feature 'Edit links for other posts are not rendered', js: true do

  let(:admin_post) { create(:current_admin_post_comment) }

  def admin
    admin_post.postable
  end

  def admin_comment
    admin_post.comments.where(commentable_id: admin.id).first
  end

  def alternate_comment
    admin_post.comments.reject { |c| c.commentable_id == admin.id }.first
  end

  before(:each) do
    login_as admin, scope: :admin

    visit admin_post_path(admin, admin_post)
  end

  scenario 'with success' do
    expect(admin_post.comments.size).to eq(3)
    expect(all('.delete-comment-link').size).to eq(1)
    expect(page).to have_selector('a', id: "delete-comment-#{admin_comment.id}")
    expect(page).not_to have_selector('a', id: "delete-comment-#{alternate_comment.id}")
  end
end
