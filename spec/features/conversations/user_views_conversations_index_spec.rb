require 'rails_helper'

RSpec.feature 'User views their conversation index' do

  let(:conversation) { create(:conversation) }

  def first_user
    conversation.sendable
  end

  def second_user
    conversation.receivable
  end

  scenario 'with no messages' do
    login_as first_user, scope: :user

    Conversation.destroy_all

    visit conversations_path

    expect(page).to have_text('No messages found!')
  end

  scenario 'with success from the the first user perspective' do
    login_as first_user, scope: :user

    visit conversations_path

    expect(page).to have_text(second_user.name)
  end

  scenario 'with success from the second user perspective' do
    login_as second_user, scope: :user

    visit conversations_path

    expect(page).to have_text(first_user.name)
  end

  scenario 'and clicks to view a specific conversation with success from the first user perspective' do
    login_as first_user, scope: :user

    visit conversations_path

    find('a', id: "conv-index-#{conversation.id}").click

    expect(page).to have_text("Conversation with #{second_user.name}")
  end

  scenario 'and clicks to view a specific conversation with success from the second user perspective' do
    login_as second_user, scope: :user

    visit conversations_path

    find('a', id: "conv-index-#{conversation.id}").click

    expect(page).to have_text("Conversation with #{first_user.name}")
  end
end
