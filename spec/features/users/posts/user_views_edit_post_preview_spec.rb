require 'rails_helper'

RSpec.feature 'A user views a post preview while editing a post', js: true do

  let(:post) { create(:post_with_user) }

  def user
    post.postable
  end

  before(:each) do
    login_as user, scope: :user

    visit edit_user_post_path(user, post)
  end

  scenario 'with success' do
    click_on 'Preview'

    expect(page).to have_text(post.post_content)

    click_on 'New Post'
    fill_in 'Post content', with: '## New Post'
    click_on 'Preview'

    expect(page).to have_selector('h2', text: 'New Post')
  end

  scenario 'with a blank content field' do
    fill_in 'Title', with: 'Testing'
    fill_in 'Post content', with: ''

    click_on 'Preview'

    expect(page).to have_text('No Content Available')
  end

end
