require 'rails_helper'

RSpec.feature 'Admin edits a user profile' do

  let(:user) { create(:user) }
  let(:admin) { create(:admin) }

  before(:each) do
    login_as admin, scope: :admin

    visit user_path(user)

    click_on 'Edit Profile'
  end

  scenario 'with success' do
    expect(page).to have_selector("input[value='#{user.email}']")

    fill_in 'Email', with: 'new_email@email.com'
    click_on 'Submit'

    expect(page).to have_text('User updated successfully!')
  end

  scenario 'with validation errors' do
    expect(page).to have_selector("input[value='#{user.email}']")

    fill_in 'Email', with: ''
    click_on 'Submit'

    expect(page).to have_text("can't be blank")
  end

end
