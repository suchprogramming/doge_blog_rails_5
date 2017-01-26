require 'rails_helper'

RSpec.feature 'User edits a post' do

  let(:post) { create(:post_with_user) }
  let(:alternate_user) { create(:alternate_user) }

  def user
    post.postable
  end

  scenario 'with success' do
    login_as user, scope: :user

    visit edit_user_post_path(user, post)

    expect(page).to have_field('Title', with: post.title)
    expect(page).to have_field('Post content', with: post.post_content)

    fill_in 'Title', with: 'New Title'
    fill_in 'Post content', with: 'Looking for me?'
    click_button 'Submit'

    expect(page).to have_text('Post successfully updated!')
    expect(page).to have_text('Looking for me?')
  end

  scenario 'when trying to mutate another user post ' do
    login_as alternate_user, scope: :user

    visit user_post_path(user, post)

    expect(page).not_to have_css('a', text: 'Edit')
    expect(page).not_to have_css('a', text: 'Delete')
  end

  scenario 'with validation errors' do
    login_as user, scope: :user

    visit edit_user_post_path(user, post)

    fill_in 'Title', with: ''
    click_button 'Submit'

    expect(page).to have_text("can't be blank")
  end

end
