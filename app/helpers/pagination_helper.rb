module PaginationHelper

  def paged_post_options
    {
      previous_label: embedded_svg("previous.svg"),
      next_label: embedded_svg("next.svg"),
      inner_window: 0,
      outer_window: 0
    }
  end

  def paged_comment_options(post = nil)
    return unless post

    {
      previous_label: embedded_svg("previous.svg"),
      next_label: embedded_svg("next.svg"),
      inner_window: 0,
      outer_window: 0,
      params: {
        controller: 'posts',
        action: 'show',
        id: @post.id
      }
    }
  end

  def paged_collection(collection = nil, per = nil)
    return unless collection

    @paged = collection.paginate(page: params[:page], per_page: per || 25)
  end
  
end
