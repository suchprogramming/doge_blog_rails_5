module PaginationHelper
  def paged_post_options
    {
      window: 1,
      outer_window: 1
    }
  end

  def paged_comment_options(post_id = nil)
    return unless post_id

    {
      window: 0,
      outer_window: 1,
      params: {
        controller: 'posts',
        action: 'show',
        id: post_id
      }
    }
  end
end
