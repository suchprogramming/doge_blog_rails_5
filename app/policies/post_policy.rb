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
    @user.try(:admin?) && @user.active || @post.active
  end

  def create?
    @user.polymorphic_owner?(@post) && @user.active
  end

  def edit?
    create?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
