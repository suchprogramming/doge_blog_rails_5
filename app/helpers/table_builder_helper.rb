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

  def user_table_attrs
    [
      'email',
      'created_at',
      'sign_in_count',
      'last_sign_in_at',
      'last_sign_in_ip',
      'active',
      'avatar_approved'
    ]
  end

  def user_table_header
    [
      'E-Mail',
      'Join Date',
      'Sign In Count',
      'Last Sign In',
      'Last IP',
      'Active',
      'Avatar Approved'
    ]
  end

  def post_table_attrs
    [
      'title',
      'created_at',
      'active'
    ]
  end

  def post_table_header
    [
      'Title',
      'Date Created',
      'Active',
      'Poster'
    ]
  end

  def invitation_table_attrs
    [
      'recipient_email',
      'expires_at',
      'accepted_at',
      'admin_id',
      'created_at'
    ]
  end
end
