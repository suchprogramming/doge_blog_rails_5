require 'rails_helper'

RSpec.feature 'Admin views posts without ability to vote' do

  let!(:post) { create(:current_user_post) }
  let(:admin) { create(:admin) }

  def user
    post.postable
  end

  scenario 'on the post show route without the ability to vote' do
    login_as admin, scope: :admin

    visit user_post_path(user, post)

    expect(page).to have_selector('div', id: "score-area-#{post.id}")
    expect(page).not_to have_selector('.vote-button')
  end
end
