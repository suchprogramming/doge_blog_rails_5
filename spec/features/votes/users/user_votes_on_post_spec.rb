require 'rails_helper'

RSpec.feature 'User votes on a post', js: true do

  let!(:post) { create(:current_user_post) }

  def user
    post.postable
  end

  before(:each) do
    login_as user, scope: :user

    visit user_post_path(user, post)
  end

  scenario 'with success on new vote creation' do
    expect(page).to have_text(post.title)

    click_button("vote-post-up-#{post.id}")
    wait_for_ajax

    expect(find("#post-score-#{post.id}").text).to eq("1")
    expect(page).to have_text('Voted!')
  end

  scenario 'with success on vote update' do
    expect(page).to have_text(post.title)

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
    expect(page).to have_text(post.title)

    click_button("vote-post-up-#{post.id}")
    wait_for_ajax

    expect(find("#post-score-#{post.id}").text).to eq("1")
    expect(page).to have_text('Voted!')

    click_button("vote-post-up-#{post.id}")
    wait_for_ajax

    expect(find("#post-score-#{post.id}").text).to eq("1")
    expect(page).to have_text("Already voted!")
  end

  scenario 'without the ability to vote for an inactive account' do
    user.update(active: false)

    page.evaluate_script("window.location.reload()")

    expect(page).to have_text(post.title)
    expect(page).to have_selector('div', id: "score-area-#{post.id}")
    expect(page).to have_selector('svg', class: 'disabled')
    expect(page).not_to have_selector('.vote-button')
  end
end
