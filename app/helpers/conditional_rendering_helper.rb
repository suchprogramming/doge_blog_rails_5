module ConditionalRenderingHelper

  # POST RENDERING

  def posts_inactive_or_new_link(user_scope = nil)
    return unless user_scope

    user_scope.active ? posts_new_post_link(user_scope) :
                        render('shared/inactive_account')
  end

  def posts_new_post_link(user_scope = nil)
    return unless user_scope

    link_to 'New Post',
            new_polymorphic_path([user_scope, :post]),
            class: "waves-effect waves-teal btn"
  end

  # NEW SESSION FORM RENDERING

  def sessions_new_password_link(controller_name = nil, resource_name = nil)
    return unless controller_name == 'sessions' && resource_name

    link_to 'Forgot your password?',
            "/#{resource_name.to_s.pluralize}/password/new"
  end

  def sessions_sign_up_link(resource_name = nil)
    return unless resource_name && resource_name == :user

    content_tag(:div, class: 'sign-up') do
      link_to 'No account?  Sign up!',
              new_user_registration_path,
              class: "waves-effect waves-teal btn-flat"
    end
  end

  # USER AVATAR RENDERING

  def render_user_avatar(user = nil, size = :thumb, css_class = nil)
    if user && user.avatar_approved
      image_tag user.avatar(size), class: css_class
    else
      default_avatar(size)
    end
  end

  def default_avatar(size = nil)
    image_tag "/assets/default-avatar_#{size}.png", class: 'default-user-avatar'
  end

end
