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

  def embedded_svg(filename, options = {})
    assets = Rails.application.assets
    file = assets.find_asset(filename).source.force_encoding("UTF-8")
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css "svg"
    if options[:class].present?
      svg["class"] = options[:class]
    end
    raw doc
  end

end
