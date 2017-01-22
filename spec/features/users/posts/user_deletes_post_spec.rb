require 'rails_helper'

RSpec.feature 'User deletes a post' do

  let(:post) { create(:post_with_user) }
  let(:current_user) { create(:user, email: 'second_user@email.com') }

  scenario 'with success' do
    login_as post.postable, scope: :user

    visit user_post_path(post.postable, post)

    find('a.modal-trigger').click
    find("a#delete-post-#{post.id}").click

    expect(page).to have_text('Post successfully deleted!')
  end

  scenario 'with errors' do
    login_as current_user

    visit user_post_path(post.postable, post)

    expect(page).to_not have_content('a.modal-trigger')
    expect(page).to_not have_content("a#delete-post-#{post.id}")
  end

end