require 'rails_helper'

RSpec.describe MarkdownPreview, type: :model do

  let(:params) { ActionController::Parameters.new({ post_content: '## Test' }) }

  describe '#check_for_valid_content' do
    it 'should return text matching the specific keys when a valid hash is present' do
      preview_object = MarkdownPreview.new(params)

      expect(preview_object.check_for_valid_content).to eq('## Test')
    end

    it 'should return nil if no valid hash is present' do
      expect(MarkdownPreview.new({ bob: 'ross'}).check_for_valid_content).to eq(nil)
      expect(MarkdownPreview.new(nil).check_for_valid_content).to eq(nil)
      expect(MarkdownPreview.new().check_for_valid_content).to eq(nil)
    end
  end

  describe '#parse_text' do
    it 'should return parsed markdown if a valid hash is present' do
      preview_object = MarkdownPreview.new(params)

      expect(preview_object.parse_text).to eq("<h2>Test</h2>\n")
    end

    it "should return 'No Content Available' when invalid text is parsed" do
      expect(MarkdownPreview.new().parse_text)
    end
  end
end
