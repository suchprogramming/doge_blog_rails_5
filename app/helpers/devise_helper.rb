module DeviseHelper
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
end
