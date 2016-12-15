require 'rails_helper'

describe PostPolicy do

  let(:current_admin_post) { create(:current_admin_post) }
  let(:alternate_admin_post) { create(:alternate_admin_post) }

  let(:current_user_post) { create(:current_user_post) }
  let(:alternate_user_post) { create(:alternate_user_post) }

  def current_user
    current_user_post.postable
  end

  def alternate_user
    alternate_user_post.postable
  end

  def current_admin
    current_admin_post.postable
  end

  def alternate_admin
    alternate_admin_post.postable
  end

  subject { PostPolicy }

  permissions :new?, :create? do
    it "allows a user to create a post if user params match post params" do
      expect(subject).to permit(current_user, current_user_post)
    end

    it "allows an admin to create a post if admin params match post params" do
      expect(subject).to permit(current_admin, current_admin_post)
    end

    it "denies access for a user if user params do not match post params" do
      expect(subject).not_to permit(current_user, alternate_user_post)
    end

    it "denies access for an admin if admin params do not match post params" do
      expect(subject).not_to permit(current_admin, alternate_admin_post)
    end

    it "prevents an admin from making a post as a user" do
      expect(subject).not_to permit(current_admin, current_user_post)
    end

    it "prevents a user from making a post as an admin" do
      expect(subject).not_to permit(current_user, current_admin_post)
    end
  end

  permissions :edit?, :update?, :destroy? do
    it "denies access if a user does not own a post resource" do
      expect(subject).not_to permit(current_user, alternate_user_post)
    end

    it "prevents a user from mutating an inactive post" do
      current_user_post.update_attributes(active: false)

      expect(subject).not_to permit(current_user, current_user_post)
    end

    it "grants access if ownership can be verified and the post is active" do
      expect(subject).to permit(current_user, current_user_post)
    end

    it "grants an admin access to edit an active user post" do
      expect(subject).to permit(current_admin, current_user_post)
    end

    it "grants an admin access to edit an inactive user post" do
      current_user_post.update_attributes(active: false)

      expect(subject).to permit(current_admin, current_user_post)
    end
  end

  permissions :show? do
    it "allows users to view active posts" do
      expect(subject).to permit(current_user, alternate_user_post)
    end

    it "prevents users from viewing any inactive post" do
      current_user_post.update_attributes(active: false)

      expect(subject).not_to permit(current_user, current_user_post)
    end

    it "allows an admin to view an inactive post" do
      current_user_post.update_attributes(active: false)

      expect(subject).to permit(current_admin, current_user_post)
    end
  end
end
