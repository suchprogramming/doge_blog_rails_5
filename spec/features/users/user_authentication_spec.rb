require "rails_helper"

RSpec.feature "User authentication", :type => :feature do

  scenario "with errors" do
    visit "users/sign_in"

    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "wrong!"

    click_button "Sign In"

    expect(page).to have_text("Invalid Email or password.")
  end

  scenario "with success" do
    user = create(:user)

    visit "users/sign_in"

    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "123456"

    click_button "Sign In"

    expect(page).to have_text("Signed in successfully.")

    click_on "Sign Out"

    expect(page).to have_text("Signed out successfully.")
  end

end
