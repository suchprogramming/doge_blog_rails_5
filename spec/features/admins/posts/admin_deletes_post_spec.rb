require 'rails_helper'

RSpec.feature 'Admin deletes a post' do

  let(:post) { create(:post_with_user) }

  scenario 'with success' do
    login_as create(:admin)
    visit user_post_path(post.postable, post)
    find('a.modal-trigger').click
    find("#delete-post-#{post.id}").click

    expect(page).to have_text('Post successfully deleted!')
  end
  
end
