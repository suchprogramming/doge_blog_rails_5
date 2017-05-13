require 'rails_helper'

RSpec.describe Conversation, type: :model do
  it { should belong_to(:sendable) }
  it { should belong_to(:receivable) }
  it { should validate_uniqueness_of(:sendable_id).scoped_to(:receivable_id) }
  it { should have_many(:messages) }
end
