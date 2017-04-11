require 'rails_helper'

RSpec.feature 'User searches for a post', js: true do

  let!(:post) { create(:current_user_post_filter_search) }

  before(:each) do
    visit root_path
  end

  scenario 'with success' do
    find("input#post_search").set("wrong title\n")

    expect(page).not_to have_selector('h5', text: post.title)

    find("input#post_search").set("#{post.title}\n")

    expect(page).to have_selector('h5', text: post.title)
  end

  scenario 'with no posts found' do
    find("input#post_search").set("wrong title\n")

    expect(page).not_to have_selector('h5', text: post.title)
  end

  scenario 'with the last day filter applied' do
    find("input#post_search").set("#{post.title}\n")
    select('Last Day', from: 'post-filter-select', visible: false)

    expect(all('.card-panel').count).to eq(1)
  end

  scenario 'with the last week filter applied' do
    find("input#post_search").set("#{post.title}\n")
    select('Last Week', from: 'post-filter-select', visible: false)

    expect(all('.card-panel').count).to eq(2)
  end

  scenario 'with the last month filter applied' do
    find("input#post_search").set("#{post.title}\n")
    select('Last Month', from: 'post-filter-select', visible: false)

    expect(all('.card-panel').count).to eq(3)
  end

  scenario 'when searching through an already filtered list' do
    post.update(title: 'Testing Filter & Then Search')

    select('Last Week', from: 'post-filter-select', visible: false)

    expect(page).to have_text('Testing Search & Filter')
    expect(page).to have_text('Testing Filter & Then Search')

    find("input#post_search").set("#{post.title}\n")

    expect(page).not_to have_text('Testing Search & Filter')
    expect(page).to have_text('Testing Filter & Then Search')
  end
end
