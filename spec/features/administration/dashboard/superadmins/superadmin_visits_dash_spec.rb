require 'rails_helper'

RSpec.feature 'Admin visits dashboard' do

  let(:super_admin) { create(:super_admin) }

  scenario 'with success' do
    login_as super_admin, scope: :admin

    visit root_path

    find('ul.right').find('a', exact_text: 'Admin').click

    expect(page).to have_css('a', text: 'Admin')
    expect(page).to have_css('a', text: 'Posts')
    expect(page).to have_css('a', text: 'Users')
    expect(page).to have_css('a', text: 'Manage Admins')
    expect(page).to have_css('a', text: 'Admin Invites')
  end
end
