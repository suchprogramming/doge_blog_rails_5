require 'rails_helper'

RSpec.feature 'User views their conversation index' do

  let(:conversation) { create(:conversation) }

  def sender
    conversation.sendable
  end

  def recipient
    conversation.receivable
  end

  scenario 'with no messages' do
    login_as sender, scope: :user

    Conversation.destroy_all

    visit conversations_path

    expect(page).to have_text('No messages found!')
  end

  scenario 'from the the sender perspective' do
    login_as sender, scope: :user

    visit conversations_path

    expect(page).to have_text(recipient.name)
  end

  scenario 'from the recipient perspective' do
    login_as recipient, scope: :user

    visit conversations_path

    expect(page).to have_text(sender.name)
  end
end
