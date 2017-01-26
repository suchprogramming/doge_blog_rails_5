module TableBuilderHelper

  def build_header(attrs)
    attrs.each { |attr| concat(content_tag(:th, attr.titleize)) }
  end

  def build_row(resource, attrs)
    attrs.each { |attr| concat(content_tag(:td, resource[attr])) }
  end

  def no_records_found
    render 'shared/table_no_records'
  end

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

  def invitation_attrs
    [
      'id',
      'recipient_email',
      'expires_at',
      'accepted_at',
      'admin_id',
      'created_at'
    ]
  end

end
