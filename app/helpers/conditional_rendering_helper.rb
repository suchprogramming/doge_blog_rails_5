module ConditionalRenderingHelper

  # POST RENDERING

  def posts_inactive_or_new_link(user_scope = nil)
    return unless user_scope

    user_scope.active ? posts_new_post_link(user_scope) :
                        render('shared/inactive_account')
  end

  def post_creator_link(current_user = nil, post = nil)
    return post.postable.name unless current_user

    link_to post.postable.name, polymorphic_path(post.postable)
  end

  def posts_new_post_link(user_scope = nil)
    return unless user_scope

    link_to 'New Post',
            new_polymorphic_path([user_scope, :post]),
            class: "waves-effect waves-teal btn"
  end

  # COMMENT RENDERING

  def commenter_link(current_user = nil, comment = nil)
    return comment.commentable.name unless current_user

    link_to comment.commentable.name, polymorphic_path(comment.commentable)
  end

  # NEW SESSION FORM RENDERING

  def sessions_new_password_link(controller_name = nil, resource_name = nil)
    return unless controller_name == 'sessions' && resource_name

    content_tag(:div) do
      link_to 'Forgot your password?',
              "/#{resource_name.to_s.pluralize}/password/new",
              class: "waves-effect waves-teal btn-flat"
    end
  end

  def sessions_sign_up_link(resource_name = nil)
    return unless resource_name && resource_name == :user

    content_tag(:div) do
      link_to 'No account?  Sign up!',
              new_user_registration_path,
              class: "waves-effect waves-teal btn-flat"
    end
  end

  # USER AVATAR RENDERING

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

  # NAVIGATION RENDERING

  def default_links
    capture do
      concat content_tag(:li) { link_to('Log In', new_user_session_path) }
      concat content_tag(:li) { link_to('Sign Up', new_user_registration_path) }
    end
  end

  def current_user_links(user_scope = nil)
    return unless user_scope

    capture do
      concat content_tag(:li) { link_to 'My Account', edit_user_registration_path }
      concat content_tag(:li) { link_to "Sign Out (#{user_scope.name})", destroy_user_session_path, method: :delete }
    end
  end

  def current_admin_links(user_scope = nil)
    return unless user_scope.try(:admin?)

    capture do
      concat content_tag(:li) { link_to 'Admin', administration_dashboard_path } if user_scope.active
      concat content_tag(:li) { link_to 'My Account', edit_admin_registration_path }
      concat content_tag(:li) { link_to "Sign Out (#{user_scope.name})", destroy_admin_session_path, method: :delete }
    end

  end

end
