require 'rails_helper'

RSpec.feature 'An admin leaves a comment on a post', js: true do

  let(:user_post) { create(:current_user_post) }
  let(:admin) { create(:admin) }

  def user
    user_post.postable
  end

  before(:each) do
    login_as admin, scope: :admin

    visit user_post_path(user, user_post)

    expect(page).to have_selector('div', class: 'comments-header')
  end

  scenario 'with success' do
    click_on 'New Comment'

    expect(page).to have_selector('#new_comment')

    fill_in 'comment_text', with: 'I agree with myself!'
    click_on 'Submit'

    expect(page).to have_text('Comment created!')
    expect(page).to have_text('I agree with myself!')
  end

  scenario 'with validation errors' do
    click_on 'New Comment'

    expect(page).to have_selector('#new_comment')

    click_on 'Submit'

    expect(page).to have_text("can't be blank")
  end

  scenario 'when canceling a comment addition' do
    click_on 'New Comment'

    expect(page).to have_selector('#new_comment')

    find('#cancel-comment').click

    expect(page).not_to have_selector('#new_comment')
  end

  scenario 'when clicking new comment multiple times' do
    find('#new-comment-link').click

    wait_for_ajax

    expect(all('form#new_comment').length).to eq(1)

    find('#new-comment-link').click

    wait_for_ajax

    expect(all('form#new_comment').length).to eq(1)
  end
end
