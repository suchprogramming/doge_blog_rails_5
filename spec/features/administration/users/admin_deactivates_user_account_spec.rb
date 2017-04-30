require 'rails_helper'

RSpec.feature 'Admin deactivates user account' do

  let(:user) { create(:user) }
  let(:admin) { create(:admin) }

  scenario 'with success' do
    login_as admin, scope: :admin

    visit user_path(user)

    click_on 'Edit Profile'

    expect(page).to have_text('Edit Profile')
    expect(page).to have_text('Administration')
    expect(find('#user_active')).to be_checked

    uncheck 'user[active]'
    click_on 'Submit'

    expect(page).to have_text('User updated successfully!')
  end
end
