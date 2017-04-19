require 'rails_helper'

RSpec.describe PostsHelper, :type => :helper do

  def inactive_msg
    'Your account is currently inactive'
  end

  describe '#posts_inactive_or_new_link' do
    it 'returns nil if no user scope is available' do
      expect(posts_inactive_or_new_link).to eq(nil)
    end

    it 'returns the new post link for active user accounts' do
      user = User.new(id: 1)

      expect(posts_inactive_or_new_link(user)).to include('/users/1/posts/new')
    end

    it 'renders the inactive account partial' do
      user = User.new(id: 1, active: false)

      expect(posts_inactive_or_new_link(user)).to have_text(inactive_msg)
    end
  end

  describe '#post_creator_link' do
    it 'returns if no post object is present' do
      expect(post_creator_link).to eq(nil)
    end

    it 'returns the post creator name if no current user is present' do
      post = Post.new(postable: User.new(name: 'bobross'))

      expect(post_creator_link(nil, post)).to eq('bobross')
    end

    it 'returns a link to the post creator profile if a current user is present' do
      post = create(:current_user_post)

      expect(post_creator_link(post.postable, post)).to include("/users/#{post.postable.id}")
    end
  end

  describe '#posts_new_post_link' do
    it 'returns nil if no user scope is available' do
      expect(posts_new_post_link).to eq(nil)
    end

    it 'returns the new post link for active user accounts' do
      user = User.new(id: 1)

      expect(posts_new_post_link(user)).to include('/users/1/posts/new')
    end
  end
end
