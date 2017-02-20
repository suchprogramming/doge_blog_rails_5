module CommentsHelper
  def new_comment_link(user_scope = nil, post = nil)
    return unless user_scope && post

    link_to 'New Comment',
            new_polymorphic_path([current_any_scope, post, :comment]),
            class: 'waves-effect waves-teal btn',
            id: 'new-comment-link',
            remote: true
  end

  def edit_comment_link(user_scope = nil, post = nil, comment = nil)
    return unless user_scope && post && comment

    link_to 'Edit',
            edit_polymorphic_path([comment.commentable, post, comment]),
            class: 'edit-comment-link',
            id: "edit-comment-#{comment.id}",
            remote: true
  end

  def delete_comment_link(user_id = nil, post_id = nil, comment_id = nil)
    return unless user_id && post_id && comment_id

    link_to 'Delete',
            '#show-comment-delete',
            class: "delete-comment-link",
            id: "delete-comment-#{comment_id}",
            data: { user_id: user_id, post_id: post_id, comment_id: comment_id }
  end

  def delete_comment_modal_link
    link_to 'Delete',
            'replace-me',
            class: 'waves-effect waves-light btn-flat red-text',
            id: 'delete-comment-link-modal',
            method: 'delete',
            remote: true
  end

  def admin_flag_comment(user_id = nil, post_id = nil, comment_id = nil)
    return unless user_id && post_id && comment_id

    button_to 'Flag Comment',
              administration_comments_path,
              params: flag_comment_params(user_id, post_id, comment_id),
              class: 'flag-comment-link',
              id: "flag-comment-#{comment_id}",
              remote: true,
              method: 'patch'
  end

  def flag_comment_params(user_id = nil, post_id = nil, comment_id = nil)
    return unless user_id && post_id && comment_id

    {
      "comment[flagged]": true,
      commentable_id: user_id,
      post_id: post_id,
      comment_id: comment_id
    }
  end
end
