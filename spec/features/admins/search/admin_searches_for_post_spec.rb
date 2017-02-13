require 'rails_helper'

RSpec.feature 'Admin searches for a post and clicks to view', js: true do

  let!(:post) { create(:post_with_user) }
  let(:admin) { create(:admin) }

  before(:each) do
    login_as admin, scope: :admin

    visit administration_dashboard_path

    click_on 'Post Management'

    expect(page).to have_text(post.title)
  end

  scenario 'with success' do
    fill_in 'post_search', with: post.title

    expect(page).not_to have_text('No Records Found!')

    find("[id='#{polymorphic_path([post.postable, post])}']").click

    expect(page).to have_text post.title
  end

  scenario 'with no records found' do
    fill_in 'post_search', with: 'Bob Ross'

    expect(page).not_to have_text(post.title)
    expect(page).to have_text('No Records Found!')
  end

end
