require 'rails_helper'

RSpec.feature "A user discovers their inactive account status", :type => :feature do

  let(:user) { create(:user, active: false) }
  let(:user_post) { create(:post_with_user, postable: user) }

  before(:each) do
    login_as user, scope: :user
  end

  scenario 'while visiting the posts index with success' do
    visit root_path

    expect(page).to have_text('Your account is currently inactive')
  end

  scenario 'while viewing one of their posts with success' do
    visit user_post_path(user, user_post)

    expect(page).not_to have_text('Edit')
    expect(page).not_to have_text('Delete')
  end

end
