require 'rails_helper'

RSpec.feature 'A admin requests a new password' do

  let!(:admin) { create(:admin) }

  scenario 'with success' do
    visit new_admin_session_path

    click_on 'Forgot your password?'
    fill_in 'Email', with: admin.email
    click_on 'E-Mail Password Reset Instructions'

    expect(ActionMailer::Base.deliveries.length).to eq(1)
    expect(page).to have_text('You will receive an email with instructions on how to reset your password in a few minutes.')
  end

  scenario 'when confirming via the email with success' do
    token = admin.send_reset_password_instructions

    admin.reload

    visit "/admins/password/edit?reset_password_token=#{token}"

    expect(page).to have_text('Change password')

    fill_in 'New password', with: 1234567
    fill_in 'Confirm new password', with: 1234567
    click_on 'Update password'

    expect(page).to have_text('Your password has been changed successfully. You are now signed in.')
  end

  scenario 'with an invalid token'do
    visit '/admins/password/edit?reset_password_token=super-hacker'

    fill_in 'New password', with: 1
    fill_in 'Confirm new password', with: 2
    click_on 'Update password'

    expect(page).to have_text('Invalid reset token')
  end

  scenario 'with validation errors on initial reset' do
    visit new_admin_password_path

    click_on 'E-Mail Password Reset Instructions'

    expect(page).to have_text("can't be blank")
  end
end
