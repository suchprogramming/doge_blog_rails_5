module ApplicationHelper
  include FormErrorsHelper
  include TableBuilderHelper
  include ConditionalRenderingHelper

  def current_superadmin(user_scope = nil)
    return unless user_scope
    user_scope.try(:super_admin?)
  end

  def base_button
    { class: 'waves-effect waves-light btn'}
  end

end
