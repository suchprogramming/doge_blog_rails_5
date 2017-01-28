module PolymorphicResourceHelper
  def polymorphic_owner?(resource)
    self == resource.try(:poly_parent)
  end
end
