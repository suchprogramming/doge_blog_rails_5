require 'rails_helper'

RSpec.feature "User edits a post", :type => :feature do

  before(:each) do
    post = create(:post_with_user)
    login_as post.postable, scope: :user
    visit edit_user_post_path(post.postable, post)
  end

  scenario "with errors" do
    fill_in "Title", with: ""

    click_button "Submit"

    expect(page).to have_text("can't be blank")
  end

  scenario "with success" do
    expect(page).to have_field("Title", with: "Happy Trees")
    expect(page).to have_field("Post content", with: "Lizard Crimson")

    fill_in "Title", with: "New Title"
    fill_in "Post content", with: "Looking for me?"

    click_button "Submit"

    expect(page).to have_text("Post successfully updated!")
    expect(page).to have_text("Looking for me?")
  end

end
