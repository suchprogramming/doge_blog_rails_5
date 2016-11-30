require 'rails_helper'

RSpec.feature "Admin searches for a user", :type => :feature, js: true do

  let!(:first_user) { create(:user) }
  let!(:second_user) { create(:user, email: 'second_user@email.com') }

  scenario "with success", :driver => :selenium do
    login_as create(:admin)

    visit admins_path

    click_on "User Management"

    expect(page).to have_text(first_user.email)
    expect(page).to have_text(second_user.email)

    fill_in "user_search", with: first_user.email

    expect(page).to have_text(first_user.email)
    expect(page).not_to have_text(second_user.email)
  end
end
