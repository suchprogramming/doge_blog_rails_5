module ApplicationHelper
  include MarkdownRenderingHelper

  def current_superadmin(user_scope = nil)
    return unless user_scope

    user_scope.try(:super_admin?) && user_scope.active
  end

  def base_button
    'waves-effect waves-light btn'
  end

  def base_flat_button
    { class: 'waves-effect waves-teal btn-flat' }
  end

end
