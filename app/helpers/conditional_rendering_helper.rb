module ConditionalRenderingHelper
  def conditional_post_link
    return unless current_any_scope
    current_any_scope.active ? new_post_link : render('shared/inactive_account')
  end

  def new_post_link
    link_to 'New Post',
            new_polymorphic_path([current_any_scope, :post]),
            class: "waves-effect waves-teal btn"
  end
end
