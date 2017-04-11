require 'rails_helper'

RSpec.feature 'Inactive user views restricted posts index' do

  let(:user) { create(:user, active: false) }

  scenario 'where post creation is removed' do
    login_as user, scope: :user

    visit root_path

    expect(page).not_to have_css('a', text: 'New Post')
    expect(page).to have_text('Your account is currently inactive')
  end
end
