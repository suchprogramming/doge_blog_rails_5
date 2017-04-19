module MarkdownRenderingHelper
  def render_markdown(text_block = nil)
    return 'No Content Available' if text_block.blank?

    markdown = Redcarpet::Markdown.new(parser_renderer, parser_options)

    markdown.render(text_block).html_safe
  end

  def parser_options
    {
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      disable_indented_code_blocks: true
    }
  end

  def parser_renderer
    Redcarpet::Render::HTML
  end
end
