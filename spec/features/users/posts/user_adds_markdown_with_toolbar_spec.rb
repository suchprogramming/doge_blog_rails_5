require 'rails_helper'

RSpec.feature 'A user adds markdown to a post with the markdown toolbar', js: true do

  let(:user) { create(:user) }

  before(:each) do
    login_as user, scope: :user

    visit new_user_post_path(user)
  end

  scenario 'adding a bulleted list with success' do
    find('#bullet-list').click

    expect(find('#post_post_content').value).to eq('- ')
  end

  scenario 'adding a numbered list with success' do
    find('#number-list').click

    expect(find('#post_post_content').value).to eq('1. ')
  end

  scenario 'adding bold text with success' do
    find('#bold-text').click

    expect(find('#post_post_content').value).to eq('****')
  end

  scenario 'adding italic text with success' do
    find('#italic-text').click

    expect(find('#post_post_content').value).to eq('__')
  end

  scenario 'adding a major header with success' do
    find('#insert-header').click
    find('#insert-main-header').click

    expect(find('#post_post_content').value).to eq('## ')
  end

  scenario 'adding a sub header with success' do
    find('#insert-header').click
    find('#insert-sub-header').click

    expect(find('#post_post_content').value).to eq('### ')
  end

  scenario 'adding a paragraph header with success' do
    find('#insert-header').click
    find('#insert-para-header').click

    expect(find('#post_post_content').value).to eq('#### ')
  end

  scenario 'adding a quote with success' do
    find('#insert-quote').click

    expect(find('#post_post_content').value).to eq('> ')
  end

  scenario 'adding a link with success' do
    find('#insert-link').click

    expect(find('#post_post_content').value).to eq('[](url)')
  end

end
