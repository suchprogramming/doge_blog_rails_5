class AdminPolicy
  attr_reader :user, :admin

  def initialize(user, admin)
    @user = user
    @admin = admin
  end

  def index?
    user.try(:super_admin?) && user.active
  end

  def edit?
    index?
  end

  def update?
    index?
  end

  def show?
    true
  end

end
