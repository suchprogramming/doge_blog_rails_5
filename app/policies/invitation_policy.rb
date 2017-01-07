class InvitationPolicy
  attr_reader :user, :invitation

  def initialize(user, invitation)
    @user = user
    @invitation = invitation
  end

  def index?
    user.try(:admin?)
  end

  def new?
    create?
  end

  def create?
    user.try(:super_admin?)
  end

end
