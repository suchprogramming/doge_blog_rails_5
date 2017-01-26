require 'rails_helper'

RSpec.feature 'User updates avatar and checks public profile and post index' do

  let(:post) { create(:post_with_user) }

  def user
    post.postable
  end

  scenario 'with success while the avatar is still not approved' do
    login_as user, scope: :user

    visit edit_user_registration_path

    expect(page).to have_text('My Account')

    fill_in 'Current Password', with: user.password
    attach_file('user_avatar', Rails.root + 'app/assets/images/spacedoge.png')
    click_button 'Update'

    expect(page).to have_text('Your account has been updated successfully.')

    visit user_path(user)

    expect(find('img')[:class]).to eq('default-user-avatar')

    visit root_path

    expect(find('img')[:class]).to eq('default-user-avatar')
  end

end
