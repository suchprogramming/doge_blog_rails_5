require 'rails_helper'

RSpec.feature 'An admin manages post activity status', js: true do

  let(:post) { create(:current_user_post) }
  let(:admin) { create(:admin) }

  def user
    post.postable
  end

  scenario 'when marking a post as inactive' do
    login_as admin, scope: :admin

    visit user_post_path(user, post)

    find("#flag-post-check-#{post.id}").click

    wait_for_ajax

    expect(page).to have_text('Post deactivated!')
  end

  scenario 'when marking an inactive post as active' do
    post.update(active: false)

    login_as admin, scope: :admin

    visit user_post_path(user, post)

    find("#flag-post-check-#{post.id}").click

    wait_for_ajax

    expect(page).to have_text('Post activated!')
  end
end
