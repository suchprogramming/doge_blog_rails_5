class DashboardPolicy < Struct.new(:user, :dashboard)
  def active_admin?
    user.try(:admin?) && user.active
  end

  def active_super_admin?
    user.try(:super_admin?) && user.active
  end
end
