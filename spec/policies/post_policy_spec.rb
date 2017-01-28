require 'rails_helper'

describe PostPolicy do

  let(:user_post) { Post.new(postable: User.new(id: 1)) }
  let(:admin_post) { Post.new(postable: Admin.new(id: 1)) }

  def user
    user_post.postable
  end

  def admin
    admin_post.postable
  end

  subject { PostPolicy }

  permissions :new?, :create? do
    it 'allows a user to create a post if user params match post params' do
      expect(subject).to permit(user, user_post)
    end

    it 'allows an active admin to create a post if admin params match post params' do
      expect(subject).to permit(admin, admin_post)
    end

    it 'denies access if there is a mismatch in ownership params' do
      expect(subject).not_to permit(User.new(id: 99), user_post)
      expect(subject).not_to permit(Admin.new(id: 99), admin_post)
    end

    it 'prevents an inactive user from making a post' do
      user.active = false

      expect(subject).not_to permit(user, user_post)
    end

    it 'prevents an inactive admin from making a post' do
      admin.active = false

      expect(subject).not_to permit(admin, admin_post)
    end
  end

  permissions :edit?, :update?, :destroy? do
    it 'grants access if ownership can be verified and the post is active' do
      expect(subject).to permit(user, user_post)
    end

    it 'grants an active admin access to edit an active user post' do
      expect(subject).to permit(admin, user_post)
    end

    it 'grants an active admin access to edit an inactive user post' do
      user_post.active = false

      expect(subject).to permit(admin, user_post)
    end

    it 'denies access if a user does not own a post resource' do
      expect(subject).not_to permit(user, Post.new)
    end

    it 'prevents a user from mutating an inactive post' do
      user_post.active = false

      expect(subject).not_to permit(user, user_post)
    end

    it 'prevents an inactive user from mutating a post' do
      user.active = false

      expect(subject).not_to permit(user, user_post)
    end

    it 'prevents an inactive admin from mutating a post' do
      admin.active = false

      expect(subject).not_to permit(admin, admin_post)
    end
  end

  permissions :show? do
    it 'allows users to view active posts' do
      expect(subject).to permit(user, Post.new(active: true))
    end

    it 'allows an active admin to view an inactive post' do
      expect(subject).to permit(admin, Post.new(active: false))
    end

    it 'prevents users from viewing any inactive post' do
      expect(subject).not_to permit(user, Post.new(active: false))
    end

    it 'prevents an inactive admin from viewing an inactive post' do
      admin.active = false

      expect(subject).not_to permit(admin, Post.new(active: false))
    end
  end
end
