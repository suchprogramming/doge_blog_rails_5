require 'rails_helper'

RSpec.feature 'User creates a post' do

  let(:admin) { create(:admin) }

  before(:each) do
    login_as admin, scope: :admin
    
    visit new_admin_post_path(admin)
  end

  scenario 'with success' do
    fill_in 'Title', with: 'Drew Li'
    fill_in 'Post content', with: 'Beyerdynamics'
    click_button 'Submit'

    expect(page).to have_text('Your new post has been created!')
    expect(page).to have_text('Beyerdynamics')
  end

  scenario 'with errors' do
    fill_in 'Title', with: 'Drew Li'
    click_button 'Submit'

    expect(page).to have_text("can't be blank")
  end

end
