require 'rails_helper'

RSpec.feature 'A user views paginated comments', js: true do

  let(:user_post) { create(:current_user_post_comment_pack) }

  def user
    user_post.postable
  end

  before(:each) do
    login_as user, scope: :user

    visit user_post_path(user, user_post)
  end

  scenario 'with success' do
    expect(page).to have_selector('ul', class: 'pagination')
  end

  scenario 'when adding a comment the user is taken to the last page' do
    click_on 'New Comment'

    expect(page).to have_selector('#new_comment')

    fill_in 'comment_text', with: 'I agree with myself!'
    click_on 'Submit'

    expect(page).to have_text('Comment created!')
    expect(page).to have_text('I agree with myself!')
    expect(find('ul.pagination').find('li.active').find('a').text).to eq('2')
    expect(all('.comment-item').count).to eq(2)
  end

  scenario 'when editing a comment the current page is maintained' do
    click_on '2'
    find("#edit-comment-#{user_post.comments.last.id}").click

    expect(page).to have_selector("#edit_comment_#{user_post.comments.last.id}")
    expect(page).to have_text(user_post.comments.last.text)

    fill_in 'comment_text', with: 'Updated Text'
    click_on 'Submit'

    expect(page).to have_text('Comment updated!')
    expect(page).to have_text('Updated Text')
    expect(find('ul.pagination').find('li.active').find('a').text).to eq('2')
  end

  scenario 'when removing the last comment of a page the previous page should render' do
    expect(page).to have_selector('ul', class: 'pagination')

    click_on '2'
    find("#delete-comment-#{user_post.comments.last.id}").click

    expect(all('.comment-item').count).to eq(1)
    expect(page).to have_text('Are you sure you want to delete this comment?')

    find('#delete-comment-modal-link').click

    expect(page).to have_text('Comment removed!')
    expect(page).not_to have_selector('ul', class: 'pagination')
    expect(all('.comment-item').count).to eq(25)
  end

  scenario 'when removing a comment the current page should be kept' do
    click_on 'New Comment'

    expect(page).to have_selector('#new_comment')

    fill_in 'comment_text', with: 'I agree with myself!'
    click_on 'Submit'

    expect(page).to have_text('Comment created!')
    expect(page).to have_text('I agree with myself!')
    expect(find('ul.pagination').find('li.active').find('a').text).to eq('2')
    expect(all('.comment-item').count).to eq(2)

    find("#delete-comment-#{user_post.comments.last.id}").click

    expect(page).to have_text('Are you sure you want to delete this comment?')

    find('#delete-comment-modal-link').click

    expect(page).to have_text('Comment removed!')
    expect(page).not_to have_text('I agree with myself!')
    expect(find('ul.pagination').find('li.active').find('a').text).to eq('2')
    expect(all('.comment-item').count).to eq(1)
  end
end
