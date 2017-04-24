module TimeFormatHelper
  def default_time(timestamp = nil)
    return unless timestamp

    timestamp.strftime('%m/%d/%Y')
  end

  def detailed_time(timestamp = nil)
    return unless timestamp

    timestamp.strftime('%A, %d %b %Y %l:%M %p')
  end

  def post_show_title_time(timestamp = nil)
    return unless timestamp

    timestamp.strftime('%B %e %Y, %l:%M %p')
  end
end
