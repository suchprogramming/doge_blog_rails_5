require 'rails_helper'

RSpec.feature 'User updates their profile' do

  before(:each) do
    login_as create(:user), scope: :user
    visit edit_user_registration_path
  end

  scenario 'with success' do
    fill_in 'Email', with: 'bobross@happytrees.com'
    fill_in 'Current Password', with: '123456'
    fill_in 'New Password', with: 'terriblepassword'
    fill_in 'New Password Confirmation', with: 'terriblepassword'
    attach_file('user_avatar', Rails.root + 'app/assets/images/doge-small.png')
    click_button 'Update'

    expect(page).to have_text('Your account has been updated successfully.')
  end

  scenario 'without including a current password' do
    fill_in 'Email', with: 'bobross@happytrees.com'
    click_button 'Update'

    expect(page).to have_text("can't be blank")
  end

  scenario 'with validation errors' do
    fill_in 'Email', with: 'bobross'
    fill_in 'Current Password', with: '1'
    fill_in 'New Password', with: 'a'
    fill_in 'New Password Confirmation', with: 'b'
    click_button 'Update'

    expect(page).to have_text('is invalid')
    expect(page).to have_text('is too short (minimum is 6 characters')
    expect(page).to have_text("doesn't match Password")
  end

end
