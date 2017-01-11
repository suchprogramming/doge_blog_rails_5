require 'rails_helper'

RSpec.feature "Admin searches for a post", :type => :feature, js: true do

  let!(:post) { create(:post_with_user) }

  scenario 'with success' do
    login_as create(:admin)

    visit administration_dashboard_path

    click_on 'Post Management'

    expect(page).to have_text(post.title)

    fill_in 'post_search', with: post.title

    expect(page).to have_text(post.title)
    expect(page).not_to have_text('No Records Found!')

    find("[id='#{polymorphic_path([post.postable, post])}']").click

    expect(page).to have_text post.title

  end

  scenario 'with no records found' do
    login_as create(:admin)

    visit administration_dashboard_path

    click_on 'Post Management'

    expect(page).to have_text(post.title)
    expect(page).not_to have_text('No Records Found!')

    fill_in 'post_search', with: 'Bob Ross'

    expect(page).not_to have_text(post.title)
    expect(page).to have_text('No Records Found!')
  end

end
