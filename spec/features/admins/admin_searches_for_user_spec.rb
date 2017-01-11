require 'rails_helper'

RSpec.feature "Admin searches for a user and clicks to view profile", :type => :feature, js: true do

  let!(:user) { create(:user) }

  scenario 'with success' do
    login_as create(:admin)

    visit administration_dashboard_path

    click_on 'User Management'

    expect(page).to have_text(user.email)

    fill_in 'user_search', with: user.email

    expect(page).to have_text(user.email)
    expect(page).not_to have_text('No Records Found!')

    find("[id='#{edit_administration_user_path(user)}']").click

    expect(page).to have_text(user.email)
  end

  scenario 'with no records found' do
    login_as create(:admin)

    visit administration_dashboard_path

    click_on 'User Management'

    expect(page).to have_text(user.email)

    fill_in 'user_search', with: 'Bob Ross'

    expect(page).not_to have_text(user.email)
    expect(page).to have_text('No Records Found!')
  end

end
