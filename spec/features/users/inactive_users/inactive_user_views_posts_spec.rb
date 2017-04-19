require 'rails_helper'

RSpec.feature 'Inactive user views restricted posts' do

  let!(:post) { create(:current_user_post) }

  def user
    post.postable
  end

  before do
    login_as user, scope: :user

    user.update(active: false)

    visit root_path
  end

  scenario 'where post editing and deletion is removed' do
    click_on post.title

    expect(page).to have_text(post.title)
    expect(page).to have_text(user.name)
    expect(page).not_to have_css('a', id: '#show-post-delete')
    expect(page).not_to have_css('a', id: "edit-post-#{post.id}")
  end
end
