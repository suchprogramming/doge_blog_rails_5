module UserAvatarHelper
  def render_user_avatar(user = nil, size = :thumb, css_class = nil)
    if user && user.avatar_approved
      image_tag(user.avatar(size), class: css_class)
    else
      default_avatar(size)
    end
  end

  def default_avatar(size = nil)
    image_tag("default-avatar_#{size}.png", class: "default-user-avatar")
  end
end
