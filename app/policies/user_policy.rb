class UserPolicy
  attr_reader :current_user, :user

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    current_user.try(:admin?)
  end

  def edit?
    index?
  end

  def update?
    index?
  end

  def destroy?
    index?
  end

  def show?
    true
  end

end
