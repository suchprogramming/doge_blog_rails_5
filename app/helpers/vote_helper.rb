module VoteHelper
  def vote_btn(current_user = nil, vote_direction = '', params = {})
    return unless current_user && params[:"vote[direction]"]

    btn_direction = params[:"vote[direction]"]

    button_to votes_path, btn_config(current_user, params) do
      get_active_direction(vote_direction, btn_direction)
    end
  end

  def btn_config(current_user, params = {})
    return unless current_user && params[:"vote[direction]"]

    {
      params: {
        "vote[direction]": params[:"vote[direction]"],
        user_id: current_user.id,
        post_id: params[:post_id]
      },
      class: base_class,
      id: "vote-post-#{params[:"vote[direction]"]}-#{params[:post_id]}",
      remote: true
    }

  end

  def get_active_direction(vote_direction = nil, btn_direction = nil)
    return unless vote_direction && btn_direction

    if vote_direction == btn_direction
      embedded_svg("arrow-#{btn_direction}.svg", class: "active-#{btn_direction}")
    else
      embedded_svg("arrow-#{btn_direction}.svg")
    end
  end

  def base_class
    'waves-effect waves-teal btn-flat vote-button'
  end
end
