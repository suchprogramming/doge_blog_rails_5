require 'rails_helper'

RSpec.describe Conversation, type: :model do
  it { should belong_to(:sendable) }
  it { should belong_to(:receivable) }
  it { should validate_uniqueness_of(:sendable_id).scoped_to(:receivable_id) }
  it { should have_many(:messages) }

  let(:conversation) { create(:conversation) }
  let(:alternate_conversation) { create(:conversation) }

  def sender
    conversation.sendable
  end

  def recipient
    conversation.receivable
  end

  describe '.my_conversations' do
    it 'returns active conversations that include the supplied user scope' do
      expect(Conversation.my_conversations(sender)).to include(conversation)
      expect(Conversation.my_conversations(sender)).not_to include(alternate_conversation)
    end

    it 'excludes inactive conversations that include the supplied user scope' do
      conversation.update(sendable_active: false)

      expect(Conversation.my_conversations(sender)).not_to include(conversation)
    end
  end

  describe '.between' do
    it 'returns any conversation between two user scopes' do
      expect(Conversation.between(sender, recipient)).to include(conversation)
      expect(Conversation.between(sender, recipient)).not_to include(alternate_conversation)
    end
  end

  describe '#message_offset' do
    it 'returns a total messages count used for setting an offset' do
      expect(conversation.message_offset).to eq(2)
    end
  end
end
