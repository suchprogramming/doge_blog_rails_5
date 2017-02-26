module PaginationHelper
  def paged_comment_options(post = nil)
    return unless post

    {
      previous_label: embedded_svg("previous.svg"),
      next_label: embedded_svg("next.svg"),
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
