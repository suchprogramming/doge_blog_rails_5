require 'rails_helper'

RSpec.describe MarkdownRenderingHelper, :type => :helper do
  describe '#render_markdown' do
    it 'returns a string error message in the absence of a valid argument' do
      expect(render_markdown(nil)).to eq('No Content Available')
    end

    it 'returns parsed markedown when a valid string is present' do
      text = "## Test"

      expect(render_markdown(text)).to eq("<h2>Test</h2>\n")
    end
  end
end
