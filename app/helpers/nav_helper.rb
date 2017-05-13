module NavHelper
  def default_links
    capture do
      concat content_tag(:li) { link_to('Log In', new_user_session_path) }
      concat content_tag(:li) { link_to('Sign Up', new_user_registration_path) }
    end
  end

  def current_user_links(user_scope = nil)
    return unless user_scope

    capture do
      concat content_tag(:li) { link_to 'Messages', conversations_path }
      concat content_tag(:li) { link_to 'My Account', edit_user_registration_path }
      concat content_tag(:li) { link_to "Sign Out (#{user_scope.name})", destroy_user_session_path, method: :delete }
    end
  end

  def current_admin_links(user_scope = nil)
    return unless user_scope.try(:admin?)

    capture do
      concat content_tag(:li) { link_to 'Admin', administration_dashboard_posts_path } if user_scope.active
      concat content_tag(:li) { link_to 'Messages', conversations_path }
      concat content_tag(:li) { link_to 'My Account', edit_admin_registration_path }
      concat content_tag(:li) { link_to "Sign Out (#{user_scope.name})", destroy_admin_session_path, method: :delete }
    end
  end
end
