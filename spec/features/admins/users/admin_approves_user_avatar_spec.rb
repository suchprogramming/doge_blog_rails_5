require 'rails_helper'

RSpec.feature 'Admin approves a user avatar' do

  let(:user) { create(:user) }
  let(:admin) { create(:admin) }

  scenario 'with success' do
    login_as admin, scope: :admin

    visit user_path(user)

    click_on 'Edit Profile'

    expect(page).to have_text('Edit Profile')
    expect(page).to have_text('Administration')
    expect(find('#user_avatar_approved')).not_to be_checked

    check 'user_avatar_approved'
    click_on 'Submit'

    expect(page).to have_text('User updated successfully!')

    visit user_path(user)

    expect(find('img')[:class]).not_to eq('default-user-avatar')
  end

end
