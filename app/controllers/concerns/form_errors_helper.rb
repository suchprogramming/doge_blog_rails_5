module FormErrorsHelper
  def field_class(resource, field_name)
    resource.errors[field_name].present? ? "field-errors".html_safe : "".html_safe
  end

  def show_errors(object, field_name)
    if object.errors.any?
      if !object.errors.messages[field_name].blank?
        object.errors.messages[field_name].first
      end
    end
  end
end
