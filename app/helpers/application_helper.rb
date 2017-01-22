module ApplicationHelper
  include FormErrorsHelper
  include TableBuilderHelper
  include ConditionalRenderingHelper

  def current_superadmin
    return unless current_any_scope
    current_any_scope.try(:super_admin?)
  end

  def base_button
    { class: 'waves-effect waves-light btn'}
  end

end
