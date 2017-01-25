require 'rails_helper'

RSpec.feature 'A user discovers their inactive account status' do

  let(:post) { create(:post_with_user) }

  def user
    post.postable
  end

  before(:each) do
    user.update_attributes(active: false)

    login_as user, scope: :user
  end

  scenario 'while visiting the posts index with success' do
    visit root_path

    expect(page).to have_text('Your account is currently inactive')
  end

  scenario 'while viewing one of their posts with success' do
    visit user_post_path(user, post)

    expect(page).not_to have_text('Edit')
    expect(page).not_to have_text('Delete')
  end

end
