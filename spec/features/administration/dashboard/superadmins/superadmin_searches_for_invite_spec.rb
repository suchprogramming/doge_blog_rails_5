require 'rails_helper'

RSpec.feature 'Superadmin searches for an admin invite', js: true do

  let!(:invitation) { create(:invitation) }
  let(:super_admin) { create(:super_admin) }

  before(:each) do
    login_as super_admin, scope: :admin

    visit administration_dashboard_invitations_path

    expect(page).to have_text(invitation.recipient_email)
  end

  scenario 'with success' do
    fill_in 'invite_search', with: "#{invitation.recipient_email}\n"

    expect(page).to have_text invitation.recipient_email
    expect(page).not_to have_text('No Records Found!')
  end

  scenario 'with no records found' do
    fill_in 'invite_search', with: "bobross@lizardcrimson.com\n"

    expect(page).not_to have_text(invitation.recipient_email)
    expect(page).to have_text('No Records Found!')
  end

  scenario 'when a search reset occurs' do
    fill_in 'invite_search', with: "wrong!\n"

    expect(page).to have_text('No Records Found!')

    click_on 'RESET'

    expect(page).to have_text invitation.recipient_email
    expect(page).not_to have_text('No Records Found!')
  end
end
