class PostPolicy < ApplicationPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def new?
    create?
  end

  def show?
    user.class == Admin || post.active
  end

  def create?
    user.polymorphic_owner?(post)
  end

  def edit?
    update?
  end

  def update?
    user.class == Admin || create? && post.active
  end

  def destroy?
    update?
  end
end
