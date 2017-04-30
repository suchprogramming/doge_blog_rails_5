class Administration::CommentPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def update?
    @user.try(:admin?) && @user.active?
  end
end
