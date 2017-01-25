require 'rails_helper'

RSpec.feature 'Admin edits a user profile' do

  let(:user) { create(:user) }
  let(:admin) { create(:admin) }

  scenario 'with success' do
    login_as admin, scope: :admin

    visit user_path(user)
    
    click_on 'Edit Profile'

    expect(page).to have_selector("input[value='#{user.email}']")

    fill_in 'Email', with: 'new_email@email.com'
    click_on 'Submit'

    expect(page).to have_text('User updated successfully!')
  end

end
