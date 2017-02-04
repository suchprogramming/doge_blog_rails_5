class MarkdownController < ApplicationController

  def process_markdown
    @result = MarkdownParser.new(params).parse_text
    
    render json: { parsed_content: @result }
  end

end
