module SvgIconHelper
  def tooltip_options(svg, options)
    return unless svg && options

    svg["class"] = 'tooltipped'
    svg["data-tooltip"] = options.dig(:data, :tooltip)
    svg["data-position"] = options.dig(:data, :position)
    svg["data-delay"] = options.dig(:data, :delay)
  end

  # https://robots.thoughtbot.com/organized-workflow-for-svg
  def embedded_svg(filename, options = {})
    return if filename.blank?

    assets = Rails.application.assets
    file = assets.find_asset(filename).source.force_encoding("UTF-8")
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css "svg"
    svg["class"] = options.dig(:class)
    svg["id"] = options.dig(:id)
    tooltip_options(svg, options[:config]) if options.dig(:config)
    raw doc
  end

  def toolbar_config(text = '')
    { data: { position: 'top', delay: 300, tooltip: text }, class: 'tooltipped' }
  end
end
