require 'rails_helper'

RSpec.describe ConditionalRenderingHelper, :type => :helper do

  describe 'POST RENDERING HELPERS' do

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
      it 'returns the post creator email if no current user is present' do
        post = Post.new(postable: User.new(email: 'test@test.com'))

        expect(post_creator_link(nil, post)).to eq('test@test.com')
      end

      it 'returns a link to the post creator profile if a current user is present' do
        post = create(:post_with_user)

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

  describe 'NEW SESSION RENDERING HELPERS' do

    describe '#sessions_new_password_link' do
      it 'returns nil when no controller context is available' do
        expect(sessions_new_password_link).to eq(nil)
      end

      it 'returns a forgotten password link for a user' do
        expect(sessions_new_password_link('sessions', :user)).to include('/users/password/new')
      end

      it 'returns a forgotten password link for an admin' do
        expect(sessions_new_password_link('sessions', :admin)).to include('/admins/password/new')
      end
    end

    describe '#sessions_sign_up_link' do
      it 'returns nil when no resource name is available' do
        expect(sessions_sign_up_link).to eq(nil)
      end

      it 'returns a link for new user registration' do
        expect(sessions_sign_up_link(:user)).to include('/users/sign_up')
      end
    end
  end

  describe 'USER AVATAR RENDERING' do

    def avatar_attrs
      {
        avatar_approved: true,
        avatar_file_name: '/assets/spacedoge.png',
        avatar_content_type: 'image/pdf'
      }
    end

    describe '#render_user_avatar' do
      it 'returns the user designated avatar after admin approval' do
        expect(render_user_avatar(User.new(avatar_attrs), :thumb))
          .to include('/thumb/spacedoge.png')
      end

      it 'renders the default avatar when a user avatar is not approved' do
        expect(render_user_avatar(User.new)).to include('default-user-avatar')
      end
    end
  end

end
