require 'rails_helper'

RSpec.feature 'User views profiles' do

  let(:super_admin) { create(:super_admin) }
  let(:admin) { create(:admin) }
  let(:user) { create(:user) }

  scenario 'where editing is disabled for user profiles' do
    login_as user, scope: :user

    visit user_path(user)

    expect(page).to have_text(user.name)
    expect(page).not_to have_css('a', text: 'Edit Profile')
  end

  scenario 'where editing is disabled for admin profiles' do
    login_as user, scope: :user

    visit admin_path(admin)

    expect(page).to have_text(admin.name)
    expect(page).not_to have_css('a', text: 'Edit Profile')
  end

  scenario 'where editing is disabled for super admin profiles' do
    login_as user, scope: :user

    visit admin_path(super_admin)

    expect(page).to have_text(super_admin.name)
    expect(page).not_to have_css('a', text: 'Edit Profile')
  end
end
