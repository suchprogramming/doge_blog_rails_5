require 'rails_helper'

RSpec.describe ConditionalRenderingHelper, :type => :helper do

  describe 'POST RENDERING HELPERS' do

    def inactive_msg
      "Your account is currently inactive"
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

end
