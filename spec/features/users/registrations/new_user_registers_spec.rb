require 'rails_helper'

RSpec.feature 'a new user registers on the site' do

  scenario 'with success' do
    visit root_path

    find('ul.right').find('a', text: 'Sign Up').click
    fill_in 'Email', with: 'newuser@awesome.com'
    fill_in 'Password', with: 'BeckySadie'
    fill_in 'Password confirmation', with: 'BeckySadie'
    click_button 'Sign Up'

    expect(page).to have_text('Welcome! You have signed up successfully.')
  end

  scenario 'with validation errors' do
    visit root_path

    find('ul.right').find('a', text: 'Sign Up').click
    fill_in 'Email', with: 'bad'
    fill_in 'Password', with: 'bb8'
    fill_in 'Password confirmation', with: 'luke'
    click_button 'Sign Up'

    expect(page).to have_text('is invalid')
    expect(page).to have_text('is too short (minimum is 6 characters)')
    expect(page).to have_text("doesn't match Password")
  end

end
