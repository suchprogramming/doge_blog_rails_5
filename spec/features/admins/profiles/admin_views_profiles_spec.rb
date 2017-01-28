require 'rails_helper'

RSpec.feature 'Admin views profiles' do

  let(:super_admin) { create(:super_admin) }
  let(:admin) { create(:admin) }
  let(:user) { create(:user) }

  scenario 'where editing is enabled for user profiles' do
    login_as admin, scope: :admin

    visit user_path(user)

    expect(page).to have_text(user.email)
    expect(page).to have_css('a', text: 'Edit Profile')
  end

  scenario 'where editing is disabled for admin profiles' do
    login_as admin, scope: :admin

    visit admin_path(admin)

    expect(page).to have_text(admin.email)
    expect(page).not_to have_css('a', text: 'Edit Profile')
  end

  scenario 'where editing is disabled for super admin profiles' do
    login_as admin, scope: :admin

    visit admin_path(super_admin)

    expect(page).to have_text(super_admin.email)
    expect(page).not_to have_css('a', text: 'Edit Profile')
  end

end
