require 'rails_helper'

RSpec.feature 'Admin deletes a post' do

  let(:post) { create(:post_with_user) }
  let(:admin) { create(:admin) }

  def user
    post.postable
  end

  scenario 'with success' do
    login_as admin, scope: :admin

    visit user_post_path(user, post)

    find('a', text: 'Delete', class: 'modal-trigger').click
    find('a', text: 'Delete Post').click

    expect(page).to have_text('Post successfully deleted!')
  end

end
