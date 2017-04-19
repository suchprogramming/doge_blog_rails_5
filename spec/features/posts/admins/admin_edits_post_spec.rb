require 'rails_helper'

RSpec.feature 'Admin edits a post' do

  let(:admin) { create(:admin) }
  let(:post) { create(:current_user_post) }

  def user
    post.postable
  end

  before(:each) do
    login_as admin, scope: :admin

    visit edit_user_post_path(user, post)
  end

  scenario 'with success' do
    expect(page).to have_field('Title', with: post.title)
    expect(page).to have_field('Post content', with: post.post_content)

    fill_in 'Title', with: 'New Title'
    fill_in 'Post content', with: 'Looking for me?'
    click_button 'Submit'

    expect(page).to have_text('Post successfully updated!')
    expect(page).to have_text('Looking for me?')
  end

  scenario 'with validation errors' do
    expect(page).to have_field('Title', with: post.title)
    expect(page).to have_field('Post content', with: post.post_content)

    fill_in 'Title', with: ''
    click_button 'Submit'

    expect(page).to have_text("can't be blank")
  end
end
