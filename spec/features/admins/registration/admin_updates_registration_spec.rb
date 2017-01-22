require 'rails_helper'

RSpec.feature 'Admin updates their registration' do

  let(:admin) { create(:admin) }

  before(:each) do
    login_as admin

    visit root_path
    click_on 'My Account'

    expect(page).to have_text('My Account')
    expect(page).to have_text(admin.email)
  end

  scenario 'with success' do
    fill_in 'admin_email', with: 'changed_my_mind@email.com'
    fill_in 'admin_current_password', with: admin.password
    click_on 'Update'

    expect(page).to have_text('Your account has been updated successfully.')
  end

  scenario 'without a current password' do
    click_on 'Update'

    expect(page).to have_text("can't be blank")
  end

end
