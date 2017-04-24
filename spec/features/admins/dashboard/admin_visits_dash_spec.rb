require 'rails_helper'

RSpec.feature 'Admin visits dashboard' do

  let(:admin) { create(:admin) }

  scenario 'with success' do
    login_as admin, scope: :admin

    visit root_path

    find('ul.right').find('a', exact_text: 'Admin').click

    expect(page).to have_text('Admin')
    expect(page).to have_text('Posts')
    expect(page).to have_text('Users')
    expect(page).not_to have_css('a', text: 'Manage Admins')
    expect(page).not_to have_css('a', text: 'Invitations')
  end
end
