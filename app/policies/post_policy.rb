class PostPolicy < ApplicationPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def new?
    create?
  end

  def create?
    user.polymorphic_owner?(post)
  end

  def update?
    user.class == Admin || create?
  end

  def destroy?
    update?
  end
end
