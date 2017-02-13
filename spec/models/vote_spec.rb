require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to(:voteable) }
  it { should validate_presence_of(:direction).with_message("is not included in the list")}
  it { should validate_inclusion_of(:direction).in_array(%w(up down)) }
  it { should validate_uniqueness_of(:voteable_id).scoped_to(:user_id) }
end
