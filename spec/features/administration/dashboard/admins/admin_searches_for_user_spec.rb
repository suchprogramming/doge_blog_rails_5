require 'rails_helper'

RSpec.feature 'Admin searches for a user',js:true do

  let!(:user) { create(:user) }
  let(:admin) { create(:admin) }

  before(:each) do
    login_as admin, scope: :admin

    visit administration_dashboard_users_path

    expect(page).to have_text(user.email)
  end

  scenario 'and views profile with success' do
    fill_in 'user_search', with: "#{user.email}\n"

    expect(page).to have_text user.email
    expect(page).not_to have_text('No Records Found!')

    find("[id='#{edit_administration_user_path(user)}']").click

    expect(page).to have_text('Edit Profile')
    expect(find('#user_email').value).to eq(user.email)
  end

  scenario 'with no records found' do
    fill_in 'user_search', with: "bobross@happytrees.com\n"

    expect(page).not_to have_text(user.email)
    expect(page).to have_text('No Records Found!')
  end

  scenario 'when a search reset occurs' do
    fill_in 'user_search', with: "wrong!\n"

    expect(page).to have_text('No Records Found!')

    click_on 'RESET'

    expect(page).to have_text user.email
    expect(page).not_to have_text('No Records Found!')
  end
end
