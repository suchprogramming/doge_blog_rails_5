require 'rails_helper'

RSpec.feature 'Superadmin searches for an admin', js: true do

  let!(:admin) { create(:admin) }
  let(:super_admin) { create(:super_admin) }

  before(:each) do
    login_as super_admin, scope: :admin

    visit administration_dashboard_admins_path

    expect(page).to have_text(admin.email)
  end

  scenario 'and views profile with success' do
    fill_in 'admin_search', with: "#{admin.email}\n"

    expect(page).to have_text admin.email
    expect(page).not_to have_text('No Records Found!')

    find("[id='#{edit_administration_admin_path(admin)}']").click

    expect(page).to have_text('Edit Profile')
    expect(find('#admin_email').value).to eq(admin.email)
  end

  scenario 'with no records found' do
    fill_in 'admin_search', with: "bobross@lizardcrimson.com\n"

    expect(page).not_to have_text(admin.email)
    expect(page).to have_text('No Records Found!')
  end

  scenario 'when a search reset occurs' do
    fill_in 'admin_search', with: "wrong!\n"

    expect(page).to have_text('No Records Found!')

    click_on 'RESET'

    expect(page).to have_text admin.email
    expect(page).not_to have_text('No Records Found!')
  end
end
