require 'rails_helper'

RSpec.feature 'Admin deletes a post' do

  let(:post) { create(:current_admin_post) }

  def admin
    post.postable
  end

  scenario 'with success' do
    login_as admin, scope: :admin

    visit admin_post_path(admin, post)

    find('a', text: 'Delete', class: 'modal-trigger').click
    find('a', text: 'Delete Post').click

    expect(page).to have_text('Post successfully deleted!')
  end
end
