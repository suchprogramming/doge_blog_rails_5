module SvgIconHelper

  def render_icon(icon_name, options = default_options)
    return if icon_name.blank?

    image_tag icon_name, icon_options(options)
  end

  def icon_options(options)
    return unless options

    {
      data: { position: options[:pos], delay: 300, tooltip: options[:text] },
      class: options[:class],
      id: options[:id]
    }

  end

  def default_options
    { text: 'Missing Text', class: 'tooltipped', pos: 'bottom', delay: 50 }
  end

end
