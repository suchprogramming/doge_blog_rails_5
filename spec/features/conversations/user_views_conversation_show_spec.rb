require 'rails_helper'

RSpec.feature 'User views a single conversation' do

  let(:conversation) { create(:conversation) }

  def sender
    conversation.sendable
  end

  def recipient
    conversation.receivable
  end

  scenario 'from the sender perspective' do
    login_as sender, scope: :user

    visit conversation_path(conversation)

    expect(page).to have_text("Conversation with #{recipient.name}")
  end

  scenario 'from the recipient perspective' do
    login_as recipient, scope: :user

    visit conversation_path(conversation)

    expect(page).to have_text("Conversation with #{sender.name}")
  end
end
