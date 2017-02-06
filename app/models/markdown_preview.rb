class MarkdownPreview
  include MarkdownRenderingHelper

  def initialize(text = {})
    @text = text
  end

  def check_for_valid_content
    @text.is_a?(ActionController::Parameters) ? @text.dig(*valid_key_path) : nil
  end

  def parse_text
    render_markdown(check_for_valid_content)
  end

  def valid_key_path
    ['post_content']
  end

end
