require 'rails_helper'

RSpec.feature 'An inactive user cannot mutate comments', js: true do

  let(:user_post) { create(:current_user_post_comment) }

  def user
    user_post.postable
  end

  before(:each) do
    login_as user, scope: :user

    user.update(active: false)
  end

  scenario 'when attempting to edit their comments' do
    expect(page).not_to have_selector('div', class: 'comment-manage-area')
  end

  scenario 'when attempting to create new comments' do
    expect(page).not_to have_selector('a', id: 'new-comment-link')
  end
end
