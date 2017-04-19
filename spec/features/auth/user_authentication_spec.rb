require 'rails_helper'

RSpec.feature 'A user logs in' do

  let(:user) { create(:user) }

  scenario 'with success' do
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_text('Signed in successfully.')

    find('ul.right').find('a', text: 'Sign Out').click

    expect(page).to have_text('Signed out successfully.')
  end

  scenario 'with errors' do
    visit new_user_session_path

    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'wrong!'
    click_button 'Sign In'

    expect(page).to have_text('Invalid Email or password.')
  end
end
