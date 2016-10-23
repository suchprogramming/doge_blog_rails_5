require "rails_helper"

RSpec.feature "Admin edits a user profile", :type => :feature do

  let(:user) { create(:user) }

  scenario "with success" do
    login_as create(:admin)
    visit user_path(user)

    click_on "Edit Profile"

    expect(page).to have_text("Profile for #{user.email}")

    fill_in "Email", with: "new_email@email.com"

    click_on "Update User"

    expect(page).to have_text("User updated successfully!")
  end
end
