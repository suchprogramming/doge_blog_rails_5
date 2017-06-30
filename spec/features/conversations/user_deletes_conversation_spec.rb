require 'rails_helper'

RSpec.feature 'User deletes a conversation' do

  let(:conversation) { create(:conversation) }

  def sender
    conversation.sendable
  end

  def recipient
    conversation.receivable
  end

  scenario 'from the sender perspective' do
    login_as sender, scope: :user

    visit conversations_path

    click_on 'Delete'

    expect(page).to have_text('Conversation Deleted!')
  end
end
