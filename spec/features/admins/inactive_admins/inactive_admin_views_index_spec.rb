require 'rails_helper'

RSpec.feature 'Inactive admin views restricted posts index' do

  let(:admin) { create(:admin, active: false) }

  scenario 'where post creation and dashboard access are removed' do
    login_as admin, scope: :admin

    visit root_path

    expect(page).not_to have_css('a', exact_text: 'Admin')
    expect(page).to have_text('Your account is currently inactive')
  end
end
