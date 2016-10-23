module ResourceOwnerHelper
  def owner?(resource)
    self == resource.public_send(resource.class.name.downcase + "able")
  end
end
