module ApplicationHelper
  include FormErrorsHelper
  include TableBuilderHelper
  include ConditionalRenderingHelper

  def safe_user_attrs
    [
      "id",
      "email",
      "created_at",
      "sign_in_count",
      "last_sign_in_at",
      "last_sign_in_ip",
      "active"
    ]
  end

  def selected_post_attrs
    [
      "id",
      "title",
      "created_at",
      "postable_type",
      "postable_id",
      "active"
    ]
  end

  def post_attrs_header
    [
      "ID",
      "Title",
      "Date Created",
      "Poster Type",
      "Poster ID",
      "Active"
    ]
  end

end
