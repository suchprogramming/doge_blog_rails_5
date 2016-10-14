require 'rails_helper'

RSpec.feature "Unauthenticated user views content", :type => :feature do

  let!(:post) { create(:post) }

  scenario "on the posts index with success" do
    visit root_path

    expect(page).to have_content("Happy Trees")
  end

  scenario "on the posts show page with success" do
    visit post_path(post)

    expect(page).to have_content("Happy Trees")
  end

end
