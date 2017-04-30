require 'rails_helper'

RSpec.feature 'Admin attempts to edit a post they do not own' do

  let(:post) { create(:current_user_post) }
  let(:admin) { create(:admin) }

  def user
    post.postable
  end

  scenario 'with no editing controls' do
    login_as admin, scope: :admin

    visit user_post_path(user, post)

    expect(page).to have_text(post.title)
    expect(page).to have_text(post.post_content)
    expect(page).not_to have_selector('a', id: "edit-post-#{post.id}")
    expect(page).not_to have_selector('a', class: 'modal-trigger red')
  end
end
