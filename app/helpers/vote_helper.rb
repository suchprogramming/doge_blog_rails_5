module VoteHelper
  def upvote_btn(user_scope = nil, post = nil)
    if user_scope.blank? || post.blank?
      log_in_to_vote('up')
    elsif user_scope.try(:admin?) || user_scope.try(:active) == false
      account_inactive_or_admin('up')
    else
      active_btn(user_scope, post, 'up')
    end
  end

  def downvote_btn(user_scope = nil, post = nil)
    if user_scope.blank? || post.blank?
      log_in_to_vote('down')
    elsif user_scope.try(:admin?) || user_scope.try(:active) == false
      account_inactive_or_admin('down')
    else
      active_btn(user_scope, post, 'down')
    end
  end

  def active_btn(user_scope = nil, post = nil, direction = nil)
    return unless user_scope && post && direction

    button_to votes_path, vote_btn_config(user_scope, post, direction) do
      get_active_direction(user_scope, post, direction)
    end
  end

  def vote_btn_config(user_scope = nil, post = nil, direction = nil)
    return unless user_scope && post && direction

    {
      params: {
        "vote[direction]": direction,
        user_id: user_scope.id,
        post_id: post.id
      },
      class: base_class,
      id: "vote-post-#{direction}-#{post.id}",
      remote: true
    }
  end

  def get_active_direction(user_scope = nil, post = nil, direction = nil)
    return unless user_scope && post && direction

    user_direction = user_scope.voted?(post)

    if user_direction == direction
      embedded_svg("arrow-#{direction}.svg", class: "active-#{direction}")
    else
      embedded_svg("arrow-#{direction}.svg")
    end
  end

  def log_in_to_vote(direction = nil)
    return unless direction

    link_to embedded_svg("arrow-#{direction}.svg"), new_user_session_path, class: base_class
  end

  def account_inactive_or_admin(direction = nil)
    return unless direction

    embedded_svg("arrow-#{direction}.svg", class: 'disabled')
  end

  def base_class
    'waves-effect waves-teal btn-flat vote-button'
  end
end
