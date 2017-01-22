require 'rails_helper'

RSpec.feature 'User authentication' do

  scenario 'with success' do
    user = create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_text('Signed in successfully.')

    click_on 'Sign Out'

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
