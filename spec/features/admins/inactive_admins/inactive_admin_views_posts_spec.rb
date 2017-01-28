require 'rails_helper'

RSpec.feature 'Inactive admin views restricted posts' do

  let(:admin) { create(:admin, active: false) }
  let!(:post) { create(:post_with_user) }

  def user
    post.postable
  end

  scenario 'where post editing and deletion is removed' do
    login_as admin, scope: :admin

    visit root_path

    click_on post.title

    expect(page).to have_text(post.title)
    expect(page).to have_text(user.email)
    expect(page).not_to have_css('a', text: 'Edit')
    expect(page).not_to have_css('a', text: 'Delete')
  end

end
