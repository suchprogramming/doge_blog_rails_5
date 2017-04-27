require 'rails_helper'

RSpec.feature 'SuperAdmin edits an admin profile' do

  let(:super_admin) { create(:super_admin) }
  let(:admin) { create(:admin) }

  before(:each) do
    login_as super_admin, scope: :admin

    visit admin_path(admin)

    click_on 'Edit Profile'
  end

  scenario 'with success' do
    expect(page).to have_selector("input[value='#{admin.email}']")

    fill_in 'Email', with: 'new_email@email.com'
    click_on 'Submit'

    expect(page).to have_text('Admin updated successfully!')
  end

  scenario 'with validation errors' do
    expect(page).to have_selector("input[value='#{admin.email}']")

    fill_in 'Email', with: ''
    click_on 'Submit'

    expect(page).to have_text("can't be blank")
  end
end
