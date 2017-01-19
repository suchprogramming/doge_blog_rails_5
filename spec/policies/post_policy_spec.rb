require 'rails_helper'

describe PostPolicy do

  let(:user_post) { Post.new(postable: User.new(id: 1)) }
  let(:admin_post) { Post.new(postable: Admin.new(id: 1)) }

  def user_poster
    user_post.postable
  end

  def admin_poster
    admin_post.postable
  end

  subject { PostPolicy }

  permissions :new?, :create? do
    it 'allows a user to create a post if user params match post params' do
      expect(subject).to permit(user_poster, user_post)
    end

    it 'allows an admin to create a post if admin params match post params' do
      expect(subject).to permit(admin_poster, admin_post)
    end

    it 'denies access for a user if user params do not match post params' do
      expect(subject).not_to permit(User.new(id: 99), user_post)
    end

    it 'denies access for an admin if admin params do not match post params' do
      expect(subject).not_to permit(Admin.new(id: 99), admin_post)
    end

    it 'prevents an admin from making a post as a user' do
      expect(subject).not_to permit(admin_poster, user_post)
    end

    it 'prevents a user from making a post as an admin' do
      expect(subject).not_to permit(user_poster, admin_post)
    end
  end

  permissions :edit?, :update?, :destroy? do
    it 'denies access if a user does not own a post resource' do
      expect(subject).not_to permit(user_poster, Post.new)
    end

    it 'prevents a user from mutating an inactive post' do
      user_post.active = false
      
      expect(subject).not_to permit(user_poster, user_post)
    end

    it 'grants access if ownership can be verified and the post is active' do
      expect(subject).to permit(user_poster, user_post)
    end

    it 'grants an admin access to edit an active user post' do
      expect(subject).to permit(admin_poster, user_post)
    end

    it 'grants an admin access to edit an inactive user post' do
      user_post.active = false

      expect(subject).to permit(admin_poster, user_post)
    end
  end

  permissions :show? do
    it 'allows users to view active posts' do
      expect(subject).to permit(user_poster, Post.new(active: true))
    end

    it 'prevents users from viewing any inactive post' do
      expect(subject).not_to permit(user_poster, Post.new(active: false))
    end

    it 'allows an admin to view an inactive post' do
      expect(subject).to permit(admin_poster, Post.new(active: false))
    end
  end
end
