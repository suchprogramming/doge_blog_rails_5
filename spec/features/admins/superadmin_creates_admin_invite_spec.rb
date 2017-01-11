require 'rails_helper'

RSpec.feature 'Superadmin creats an admin invite' do

  let(:superadmin) { create(:superadmin) }

  before(:each) do
    login_as superadmin
    visit new_superadmins_invitation_path
  end

  scenario 'with success' do
    fill_in 'invitation_recipient_email', with: 'new_admin@admin.com'

    click_button 'Submit'

    expect(page).to have_text('Invite created!')
  end
end
