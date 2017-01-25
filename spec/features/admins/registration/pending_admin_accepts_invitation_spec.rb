require 'rails_helper'

RSpec.feature 'Pending admin accepts an invite' do

  let(:invitation) { create(:invitation) }

  scenario 'with success' do
    visit administration_path(invitation.token)

    expect(page).to have_text('New Admin Creation')

    fill_in 'Email Address', with: invitation.recipient_email
    fill_in 'Password', with: 'newadmin'
    fill_in 'Password confirmation', with: 'newadmin'
    click_on 'Submit'

    expect(page).to have_text('Welcome to the team!')
  end

  scenario 'with validation errors' do
    visit administration_path(invitation.token)

    fill_in 'Email Address', with: invitation.recipient_email
    fill_in 'Password', with: 'abc'
    fill_in 'Password confirmation', with: '123'
    click_on 'Submit'

    expect(page).to have_text('is too short (minimum is 6 characters)')
    expect(page).to have_text("doesn't match Password")
  end

  scenario 'with an invalid token' do
    visit administration_path('not-so-fast-my-friend')

    expect(page).to have_text(default_pundit_error)
  end
end
