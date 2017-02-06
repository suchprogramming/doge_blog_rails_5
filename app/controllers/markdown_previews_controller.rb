class MarkdownPreviewsController < ApplicationController
  before_action :authenticate_any_scope!

  def create
    @result = MarkdownPreview.new(params).parse_text

    render json: { parsed_content: @result }
  end

end
