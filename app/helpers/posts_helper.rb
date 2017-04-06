module PostsHelper
  def posts_inactive_or_new_link(user_scope = nil)
    return unless user_scope

    if user_scope.active
      posts_new_post_link(user_scope)
    else
      render('shared/inactive_account')
    end
  end

  def post_creator_link(user_scope = nil, post = nil)
    return unless post

    if user_scope
      link_to post.postable.name, polymorphic_path(post.postable)
    else
      post.postable.name
    end
  end

  def posts_new_post_link(user_scope = nil)
    return unless user_scope

    link_to 'New Post',
            new_polymorphic_path([user_scope, :post]),
            class: "waves-effect waves-teal btn right"
  end
end
