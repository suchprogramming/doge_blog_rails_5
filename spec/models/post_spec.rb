require "rails_helper"

RSpec.describe Post, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:post_content) }
  it { should belong_to(:postable) }
  it { should have_many(:votes) }

  let(:post) { create(:post_with_user) }
  let(:alternate_user) { create(:user, email: 'bob@ross.com') }

  def user
    post.postable
  end

  describe '#up_votes' do
    it 'should return the number of up votes for a post instance' do
      post.votes << Vote.new(id: 1, voteable_id: post.id, voteable_type: 'Post', direction: 'up')

      expect(post.up_votes).to eq(1)
    end

    it 'should return 0 in the absence of any up votes' do
      expect(post.up_votes).to eq(0)
    end
  end

  describe '#down_votes' do
    it 'should return the number of up votes for a post instance' do
      post.votes << Vote.new(id: 1, voteable_id: post.id, voteable_type: 'Post', direction: 'down')

      expect(post.down_votes).to eq(1)
    end

    it 'should return 0 in the absence of any up votes' do
      expect(post.down_votes).to eq(0)
    end
  end

  describe '#score' do
    it 'should return upvotes minus downvotes' do
      post.votes.create(id: 1, user_id: user.id, voteable_id: post.id, voteable_type: 'Post', direction: 'up')
      post.votes.create(id: 2, user_id: alternate_user.id, voteable_id: post.id, voteable_type: 'Post', direction: 'down')

      expect(post.score).to eq(0)
    end
  end
end
