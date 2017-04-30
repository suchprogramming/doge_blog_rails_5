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

    it 'prevents an active admin from editing an active user post' do
      expect(subject).not_to permit(admin, user_post)
    end

    it 'prevents an active admin from editing an inactive user post' do
      user_post.active = false

      expect(subject).not_to permit(admin, user_post)
    end

    it 'denies access if a user does not own a post resource' do
      expect(subject).not_to permit(user, Post.new)
    end

    it 'allows a user to make changes to their inactive post' do
      user_post.active = false

      expect(subject).to permit(user, user_post)
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
end
