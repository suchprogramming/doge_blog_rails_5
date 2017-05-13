require 'rails_helper'

describe ConversationPolicy do

  subject { ConversationPolicy }

  let(:conversation) { create(:conversation) }

  permissions :create?, :show? do
    it 'should permit users who belong to a conversation' do
      expect(subject).to permit(conversation.sendable, conversation)
      expect(subject).to permit(conversation.receivable, conversation)
    end

    it 'should deny access if params are not matched' do
      expect(subject).not_to permit(User.new, conversation)
    end
  end
end
