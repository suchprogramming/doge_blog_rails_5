class UserPolicy
  attr_reader :current_user, :user

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    current_user.admin?
  end

  def show?
    true
  end

end
