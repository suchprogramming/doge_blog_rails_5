require "rails_helper"

RSpec.feature "User updates their profile", :type => :feature do

  before(:each) do
    login_as create( :user ), scope: :user
    visit "users/edit"
  end

  scenario "without including a password" do
    fill_in "Email", with: "bobross@happytrees.com"

    click_button "Update"

    expect(page).to have_selector("p.error-text")
  end

  scenario "with validation errors" do
    fill_in "Email", with: "bobross"
    fill_in "Current Password", with: "1"
    fill_in "New Password", with: "t"
    fill_in "New Password Confirmation", with: "t"
    attach_file("user_avatar", Rails.root + 'app/assets/images/doge-small.png')

    click_button "Update"

    expect(all('p.error-text').size).to eq(5)
  end

  scenario "with success" do
    fill_in "Email", with: "bobross@happytrees.com"
    fill_in "Current Password", with: "123456"
    fill_in "New Password", with: "terriblepassword"
    fill_in "New Password Confirmation", with: "terriblepassword"
    attach_file("user_avatar", Rails.root + 'app/assets/images/doge-small.png')

    click_button "Update"

    expect(page).to have_text("Your account has been updated successfully.")
  end

end
