class MarkdownParser
  include MarkdownRenderingHelper

  def initialize(text)
    @text = text
  end

  #needs more flexibility
  def check_for_valid_content
    @text.dig(:post, :post_content)
  end

  def parse_text
    render_markdown(check_for_valid_content)
  end

end
