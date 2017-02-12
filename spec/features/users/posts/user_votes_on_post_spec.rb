require 'rails_helper'

RSpec.feature 'User votes on a post', js: true do

  let(:post) { create(:post_with_user) }

  def user
    post.postable
  end

  before(:each) do
    login_as user, scope: :user

    visit root_path

    expect(page).to have_text(post.title)
  end

  scenario 'with success on new vote creation' do
    click_button("vote-post-up-#{post.id}")

    wait_for_ajax

    expect(find("#post-score-#{post.id}").text).to eq("1")
    expect(page).to have_text('Voted!')
  end

  scenario 'with success on vote update' do
    click_button("vote-post-up-#{post.id}")

    wait_for_ajax

    expect(find("#post-score-#{post.id}").text).to eq("1")
    expect(page).to have_text('Voted!')

    click_button("vote-post-down-#{post.id}")

    wait_for_ajax

    expect(find("#post-score-#{post.id}").text).to eq("-1")
    expect(page).to have_text('Updated!')
  end

  scenario 'with success voting the same direction twice' do
    click_button("vote-post-up-#{post.id}")

    wait_for_ajax

    expect(find("#post-score-#{post.id}").text).to eq("1")
    expect(page).to have_text('Voted!')

    click_button("vote-post-up-#{post.id}")

    wait_for_ajax

    expect(find("#post-score-#{post.id}").text).to eq("1")
    expect(page).to have_text("Already voted!")
  end
end
