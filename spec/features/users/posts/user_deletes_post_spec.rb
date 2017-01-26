require 'rails_helper'

RSpec.feature 'User deletes a post' do

  let(:post) { create(:post_with_user) }

  def user
    post.postable
  end

  scenario 'with success' do
    login_as user, scope: :user

    visit user_post_path(user, post)

    find('a', text: 'Delete', class: 'modal-trigger').click
    find('a', text: 'Delete Post').click

    expect(page).to have_text('Post successfully deleted!')
  end

end
