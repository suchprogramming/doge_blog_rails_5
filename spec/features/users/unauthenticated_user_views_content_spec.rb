require 'rails_helper'

RSpec.feature 'Unauthenticated user views content' do

  let!(:post) { create(:post_with_user) }

  scenario 'on the posts index with success' do
    visit root_path

    expect(page).to have_content('Happy Trees')
  end

  scenario 'on the posts show page with success' do
    visit user_post_path(post.postable, post)

    expect(page).to have_content('Happy Trees')
  end

end
