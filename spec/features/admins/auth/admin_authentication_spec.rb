require 'rails_helper'

RSpec.feature 'Admin authentication' do

  scenario 'with success' do
    admin = create(:admin)

    visit new_admin_session_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Sign In'

    expect(page).to have_text('Signed in successfully.')

    click_on 'Sign Out'

    expect(page).to have_text('Signed out successfully.')
  end

  scenario 'with errors' do
    visit new_admin_session_path
    fill_in 'Email', with: 'not_an_admin@hacker.com'
    fill_in 'Password', with: 'thedoge'
    click_button 'Sign In'

    expect(page).to have_text('Invalid Email or password.')
  end

end
