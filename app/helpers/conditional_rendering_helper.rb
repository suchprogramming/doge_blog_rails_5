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

  # NAVIGATION RENDERING

  def superadmin_invite(admin_scope = nil)
    return unless admin_scope.try(:super_admin?)

    content_tag(:li) { link_to 'Invites', superadmins_invitations_path }
  end

  # ADMINISTRATION RENDERING

  def edit_admin_form(admin = nil, current_admin = nil)
    return unless admin.try(:admin?) && current_admin

    if admin.id == current_admin.id
      render('form')
    else
      render('superadmin_form')
    end
  end

end
