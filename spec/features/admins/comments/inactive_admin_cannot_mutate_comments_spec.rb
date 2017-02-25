require 'rails_helper'

RSpec.feature 'An inactive admin cannot mutate comments', js: true do

  let(:user_post) { create(:current_user_post_comment) }
  let(:admin) { create(:admin, active: false) }

  def user
    user_post.postable
  end

  before(:each) do
    login_as admin, scope: :admin

    visit user_post_path(user, user_post)
  end

  scenario 'when attempting to flag a user comment' do
    expect(page).not_to have_selector('div', class: 'admin-flag-area')
  end

  scenario 'when attempting to edit their comments' do
    expect(page).not_to have_selector('div', class: 'comment-manage-area')
  end

  scenario 'when attempting to create new comments' do
    expect(page).not_to have_selector('a', id: 'new-comment-link')
  end

end
