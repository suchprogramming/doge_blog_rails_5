require 'rails_helper'

RSpec.feature 'Super admin views profiles' do

  let(:super_admin) { create(:super_admin) }
  let(:admin) { create(:admin) }
  let(:user) { create(:user) }

  scenario 'where editing is enabled for user profiles' do
    login_as super_admin, scope: :admin

    visit user_path(user)

    expect(page).to have_text(user.name)
    expect(page).to have_css('a', text: 'Edit Profile')
  end

  scenario 'where editing is enabled for admin profiles' do
    login_as super_admin, scope: :admin

    visit admin_path(admin)

    expect(page).to have_text(admin.name)
    expect(page).to have_css('a', text: 'Edit Profile')
  end

  scenario 'where editing is enabled for super admin profiles' do
    login_as super_admin, scope: :admin

    visit admin_path(super_admin)

    expect(page).to have_text(super_admin.name)
    expect(page).to have_css('a', text: 'Edit Profile')
  end
end
