class Administration::AdminPolicy
  attr_reader :user, :admin

  def initialize(user, admin)
    @user = user
    @admin = admin
  end

  def edit?
    update?
  end

  def update?
    @user.try(:super_admin?) && @user.active?
  end
end
