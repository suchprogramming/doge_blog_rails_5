class DashboardPolicy < Struct.new(:user, :dashboard)

  def index?
    user.try(:admin?) && user.active
  end

end
