require 'rails_helper'

RSpec.feature "User deletes a post", :type => :feature do

  let(:post) { create(:post) }

  before(:each) do
    login_as post.user
    visit post_path(post)
  end

  scenario "with errors" do
    # Implement pundit
  end

  scenario "with success" do
    find("a.modal-trigger").click
    find("a#delete-post-#{post.id}").click

    expect(page).to have_text("Post successfully deleted!")
  end

end
