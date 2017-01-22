require 'rails_helper'

RSpec.feature 'Superadmin visits admin index' do

  let(:superadmin) { create(:superadmin) }

  scenario 'with success' do
    login_as superadmin

    visit root_path
    click_on 'Admin'
    click_on 'Manage Admins'

    expect(page).to have_text('Admin List')
  end
  
end
