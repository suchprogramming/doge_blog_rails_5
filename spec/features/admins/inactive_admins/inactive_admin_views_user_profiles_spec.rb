require 'rails_helper'

RSpec.feature 'Inactive admin views restricted user profiles' do

  let(:admin) { create(:admin, active: false) }
  let(:user) { create(:user) }

  scenario 'where user profile editing is removed' do
    login_as admin, scope: :admin

    visit user_path(user)

    expect(page).to have_text(user.name)
    expect(page).not_to have_css('a', text: 'Edit Profile')
  end

end
