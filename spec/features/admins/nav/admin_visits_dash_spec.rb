require 'rails_helper'

RSpec.feature 'Admin visits dashboard' do

  let(:admin) { create(:admin) }

  scenario 'with success' do
    login_as admin

    visit root_path
    click_on 'Admin'

    expect(page).to have_text('Administration')
    expect(page).to have_text('Post Management')
    expect(page).to have_text('User Management')
  end
  
end
