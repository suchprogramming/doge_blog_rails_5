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
    user.owner?(post)
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
