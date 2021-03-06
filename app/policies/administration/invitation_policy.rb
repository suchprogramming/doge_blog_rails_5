class Administration::InvitationPolicy
  attr_reader :user, :invitation

  def initialize(user, invitation)
    @user = user
    @invitation = invitation
  end

  def new?
    create?
  end

  def create?
    @user.try(:super_admin?) && @user.active
  end
end
