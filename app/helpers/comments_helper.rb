module CommentsHelper
  def commenter_link(user_scope = nil, comment = nil)
    return unless comment

    if user_scope
      link_to comment.commentable.name, polymorphic_path(comment.commentable)
    else
      comment.commentable.name
    end
  end

  def new_comment_link(user_scope = nil, post = nil)
    return unless user_scope.try(:active) && post

    link_to 'New Comment',
            new_polymorphic_path([user_scope, post, :comment]),
            class: 'waves-effect waves-teal btn',
            id: 'new-comment-link',
            remote: true
  end

  def edit_comment_link(post = nil, comment = nil)
    return unless post && comment

    link_to 'Edit',
            edit_polymorphic_path([comment.commentable, post, comment]),
            class: 'edit-comment-link',
            id: "edit-comment-#{comment.id}",
            remote: true
  end

  def delete_comment_link(post = nil, comment = nil)
    return unless post && comment

    link_to 'Delete',
            polymorphic_path([comment.commentable, post, comment],
            page: get_record_index(post.comments, comment)),
            class: "delete-comment-link",
            id: "delete-comment-#{comment.id}",
            data: { target: 'show-comment-delete' }
  end

  def flag_comment_options(comment_id = nil)
    return unless comment_id

    {
      html: {
        id: "flag-comment-#{comment_id}",
        class: 'flag-comment'
      },
      remote: true
    }

  end

  def filter_flagged_comment(comment = nil)
    return unless comment

    comment.flagged ? 'This comment has been flagged by administration' : comment.text
  end

  def user_form_tag(user_scope = nil)
    return unless user_scope

    if user_scope.try(:admin?)
      hidden_field_tag(:admin_id, user_scope.id)
    else
      hidden_field_tag(:user_id, user_scope.id)
    end
  end
end
