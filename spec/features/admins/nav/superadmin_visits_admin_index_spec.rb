require 'rails_helper'

RSpec.feature 'Superadmin visits admin index' do

  let(:superadmin) { create(:superadmin) }

  scenario 'with success' do
    login_as superadmin, scope: :admin

    visit root_path

    find('ul.right').find('.dropdown-button', text: 'Admin').click
    find('ul#admin-dropdown').find('a', text: 'Manage Admins').click

    expect(page).to have_text('Admin List')
  end

end
