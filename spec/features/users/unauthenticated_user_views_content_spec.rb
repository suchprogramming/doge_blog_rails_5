require 'rails_helper'

RSpec.feature 'Unauthenticated user views content' do

  let!(:post) { create(:current_user_post) }

  scenario 'on the posts index with success' do
    visit root_path

    expect(page).to have_text(post.title)
  end

  scenario 'on the posts show page with success' do
    visit user_post_path(post.postable, post)

    expect(page).to have_text(post.title)
  end
end
