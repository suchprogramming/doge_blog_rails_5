require 'rails_helper'

RSpec.feature 'An admin logs in' do

  let(:admin) { create(:admin) }

  scenario 'with success' do
    visit new_admin_session_path

    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Sign In'

    expect(page).to have_text('Signed in successfully.')

    find('ul.right').find('a', text: 'Sign Out').click

    expect(page).to have_text('Signed out successfully.')
  end

  scenario 'with validation errors' do
    visit new_admin_session_path

    fill_in 'Email', with: 'not_an_admin@hacker.com'
    fill_in 'Password', with: 'thedoge'
    click_button 'Sign In'

    expect(page).to have_text('Invalid Email or password.')
  end
end
