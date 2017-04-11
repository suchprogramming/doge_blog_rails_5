require 'rails_helper'

RSpec.feature 'Superadmin visits admin index' do

  let(:super_admin) { create(:super_admin) }

  scenario 'with success' do
    login_as super_admin, scope: :admin

    visit root_path

    find('ul.right').find('a', exact_text: 'Admin').click

    expect(page).to have_text('Administration')

    find('a', text: 'Options').click
    find('a', text: 'Manage Admins').click

    expect(page).to have_text('Admin List')
  end
end
