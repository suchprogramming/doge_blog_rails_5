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
    user.try(:admin?) && user.active || post.active
  end

  def create?
    user.polymorphic_owner?(post) && user.active
  end

  def edit?
    update?
  end

  def update?
    user.try(:admin?) && user.active || create? && post.active
  end

  def destroy?
    update?
  end
end
