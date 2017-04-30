class Administration::UserPolicy
  attr_reader :user, :user_to_update

  def initialize(user, user_to_update)
    @user = user
    @user_to_update = user_to_update
  end

  def edit?
    update?
  end

  def update?
    @user.try(:admin?) && @user.active?
  end
end
