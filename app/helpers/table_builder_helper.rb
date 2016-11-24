module TableBuilderHelper

  def build_header(attrs)
    attrs.each { |attr| concat(content_tag(:th, attr.titleize)) }
  end

  def build_row(resource, attrs)
    attrs.each { |attr| concat(content_tag(:td, resource[attr])) }
  end

  def table_conditional_render(resource)
    if resource.length == 0
      render 'layouts/table_no_records'
    else
      render(resource)
    end
  end

end
