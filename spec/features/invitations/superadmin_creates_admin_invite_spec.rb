require 'rails_helper'

RSpec.feature 'Superadmin creates an admin invite' do

  let(:super_admin) { create(:super_admin) }

  before(:each) do
    login_as super_admin, scope: :admin

    visit new_superadmins_invitation_path
  end

  scenario 'with success' do
    fill_in 'invitation_recipient_email', with: 'new_admin@admin.com'
    click_button 'Submit'

    expect(page).to have_text('Invite created!')
  end

  scenario 'with validation errors' do
    fill_in 'invitation_recipient_email', with: ''
    click_button 'Submit'

    expect(page).to have_text("can't be blank")
  end
end
