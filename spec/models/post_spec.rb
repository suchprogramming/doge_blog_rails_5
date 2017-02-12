require "rails_helper"

RSpec.describe Post, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:post_content) }
  it { should belong_to(:postable) }
  it { should have_many(:votes) }
end
