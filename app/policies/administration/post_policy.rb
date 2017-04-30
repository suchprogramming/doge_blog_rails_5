class Administration::PostPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def update?
    @user.try(:admin?) && @user.active?
  end
end
