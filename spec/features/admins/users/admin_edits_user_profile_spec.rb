require 'rails_helper'

RSpec.feature 'Admin edits a user profile' do

  let(:user) { create(:user) }

  scenario 'with success' do
    login_as create(:admin)
    visit user_path(user)
    click_on 'Edit Profile'

    expect(page).to have_selector("input[value='#{user.email}']")

    fill_in 'Email', with: 'new_email@email.com'
    click_on 'Submit'

    expect(page).to have_text('User updated successfully!')
  end
  
end
