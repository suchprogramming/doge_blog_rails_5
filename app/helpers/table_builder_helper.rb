module TableBuilderHelper

  def build_header(attrs)
    attrs.each { |attr| concat(content_tag(:th, attr.titleize)) }
  end

  def build_row(resource, attrs)
    attrs.each { |attr| concat(content_tag(:td, resource[attr])) }
  end

  def table_conditional_render(collection, partial)
    collection.length == 0 ? no_records_found : render(partial)
  end

  def no_records_found
    render 'shared/table_no_records'
  end

end
