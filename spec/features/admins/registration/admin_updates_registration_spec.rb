require 'rails_helper'

RSpec.feature 'Admin updates their registration' do

  let(:admin) { create(:admin) }

  before(:each) do
    login_as admin, scope: :admin

    visit root_path

    find('ul.right').find('a', text: 'My Account').click

    expect(page).to have_text('My Account')
    expect(page).to have_text(admin.name)
  end

  scenario 'with success' do
    fill_in 'Email', with: 'bobross@happytrees.com'
    fill_in 'Username', with: 'NeoStar'
    fill_in 'Current Password', with: '123456'
    fill_in 'New Password', with: 'terriblepassword'
    fill_in 'New Password Confirmation', with: 'terriblepassword'
    attach_file('admin_avatar', Rails.root + 'app/assets/images/default-avatar_medium.png')
    click_button 'Update'

    expect(page).to have_text('Your account has been updated successfully.')
  end

  scenario 'without a current password' do
    fill_in 'New Password', with: 'terriblepassword'
    fill_in 'New Password Confirmation', with: 'terriblepassword'
    click_on 'Update'

    expect(page).to have_text("can't be blank")
  end

  scenario 'with validation errors' do
    fill_in 'Email', with: 'bobross'
    fill_in 'Username', with: 'yournameiswaytoolong'
    fill_in 'Current Password', with: '1'
    fill_in 'New Password', with: 'a'
    fill_in 'New Password Confirmation', with: 'b'
    click_button 'Update'

    expect(page).to have_text('is invalid')
    expect(page).to have_text('is too long (maximum is 12 characters)')
    expect(page).to have_text('is too short (minimum is 6 characters')
    expect(page).to have_text("doesn't match Password")
  end

end
