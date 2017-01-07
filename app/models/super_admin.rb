class SuperAdmin < Admin
  def self.model_name
    Admin.model_name
  end

  def super_admin?
    true
  end
end
