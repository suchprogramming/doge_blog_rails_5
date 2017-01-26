require 'rails_helper'

RSpec.feature 'Inactive user views restricted posts' do

  let!(:post) { create(:post_with_user) }

  def user
    post.postable
  end

  before do
    login_as user, scope: :user

    user.update_attributes(active: false)

    visit root_path
  end

  scenario 'where post editing and deletion is removed' do
    click_on post.title

    expect(page).to have_text(post.title)
    expect(page).to have_text(user.email)
    expect(page).not_to have_css('a', text: 'Edit')
    expect(page).not_to have_css('a', text: 'Delete')
  end

end
