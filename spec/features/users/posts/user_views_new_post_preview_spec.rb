require 'rails_helper'

RSpec.feature 'A user views a post preview while creating a post', js: true do

  let(:user) { create(:user) }

  before(:each) do
    login_as user, scope: :user

    visit new_user_post_path(user)
  end

  scenario 'with success' do
    fill_in 'Title', with: 'Testing'
    fill_in 'Post content', with: "## Testing Markdown"

    click_on 'Preview'

    expect(page).to have_selector('h2', text: 'Testing Markdown')
  end

  scenario 'with a blank content field' do
    fill_in 'Title', with: 'Testing'
    fill_in 'Post content', with: ''

    click_on 'Preview'

    expect(page).to have_text('No Content Available')
  end

end
