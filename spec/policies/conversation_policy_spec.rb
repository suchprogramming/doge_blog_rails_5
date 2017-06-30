require 'rails_helper'

describe ConversationPolicy do

  subject { ConversationPolicy }

  let(:conversation) { create(:conversation) }

  def sender
    conversation.sendable
  end

  def recipient
    conversation.receivable
  end

  def sendable_context
    { 'sendable_active' => false, 'sendable_offset' => 10 }
  end

  def receivable_context
    { 'receivable_active' => false, 'receivable_offset' => 10 }
  end

  permissions :create?, :show? do
    it 'should permit users who belong to a conversation' do
      expect(subject).to permit(sender, conversation)
      expect(subject).to permit(recipient, conversation)
    end

    it 'should deny access if params are not matched' do
      expect(subject).not_to permit(User.new, conversation)
    end
  end

  permissions :update? do
    it 'should allow the conversation sender to mark their part inactive' do
      sender.conversation_context = sendable_context

      expect(subject).to permit(sender, conversation)
    end

    it 'should allow the conversation recipient to mark their part inactive' do
      recipient.conversation_context = receivable_context

      expect(subject).to permit(recipient, conversation)
    end

    it 'should deny the sender from deactivating the recipient conversation' do
      sender.conversation_context = receivable_context

      expect(subject).not_to permit(sender, conversation)
    end

    it 'should deny the recipient from deactivating the sender conversation' do
      recipient.conversation_context = sendable_context

      expect(subject).not_to permit(recipient, conversation)
    end
  end
end
