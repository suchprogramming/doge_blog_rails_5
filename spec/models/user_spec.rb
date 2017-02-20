require "rails_helper"

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should have_attached_file(:avatar) }
  it { should validate_attachment_content_type(:avatar)
    .allowing('image/png', 'image/gif')
    .rejecting('text/plain', 'text/xml') }

  it { should have_many(:votes) }
  it { should have_many(:comments) }

  let(:post) { create(:post_with_user) }

  def user
    post.postable
  end

  describe '#voted?' do
    it 'should return the direction that a user voted for a post' do
      post.votes.create(id: 1, user_id: user.id, voteable_id: post.id, voteable_type: 'Post', direction: 'up')

      expect(user.voted?(post.id)).to eq('up')
    end

    it 'should return a blank string if no vote is found' do
      expect(user.voted?(999)).to eq('')
    end
  end
end
