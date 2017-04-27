require 'rails_helper'

RSpec.feature 'Admin searches for a post', js: true do

  let!(:post) { create(:current_user_post) }
  let(:admin) { create(:admin) }

  before(:each) do
    login_as admin, scope: :admin

    visit administration_dashboard_posts_path

    expect(page).to have_text(post.title)
  end

  scenario 'and views post with success' do
    fill_in 'post_search', with: "#{post.title}\n"

    expect(page).to have_text post.title
    expect(page).not_to have_text('No Records Found!')

    find("[id='#{polymorphic_path([post.postable, post])}']").click

    expect(page).to have_text post.title
  end

  scenario 'with no records found' do
    fill_in 'post_search', with: "Bob Ross\n"

    expect(page).not_to have_text(post.title)
    expect(page).to have_text('No Records Found!')
  end

  scenario 'when a search reset occurs' do
    fill_in 'post_search', with: "wrong!\n"

    expect(page).to have_text('No Records Found!')

    click_on 'RESET'

    expect(page).to have_text post.title
    expect(page).not_to have_text('No Records Found!')
  end
end
