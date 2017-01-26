require 'rails_helper'

RSpec.feature 'Admin visits dashboard' do

  let(:admin) { create(:admin) }

  scenario 'with success' do
    login_as admin, scope: :admin

    visit root_path

    find('ul.right').find('a', text: 'Admin').click

    expect(page).to have_text('Administration')
    expect(page).to have_text('Post Management')
    expect(page).to have_text('User Management')
    expect(page).not_to have_css('a', text: 'Options')
  end

end
