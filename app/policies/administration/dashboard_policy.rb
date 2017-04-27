class Administration::DashboardPolicy < Struct.new(:user, :dashboard)
  def posts?
    user.try(:admin?) && user.active
  end

  def users?
    posts?
  end

  def comments?
    posts?
  end

  def admins?
    user.try(:super_admin?) && user.active
  end

  def invitations?
    admins?
  end
end
