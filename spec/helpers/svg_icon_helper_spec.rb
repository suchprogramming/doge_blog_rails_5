require 'rails_helper'

RSpec.describe SvgIconHelper, :type => :helper do

  describe '#embedded_svg' do
    it 'returns an svg with a tooltip when valid arguments are present' do
      expect(embedded_svg('format-bold.svg', id: 'bold-text', config: toolbar_config('Bold Text')))
        .to include('class="tooltipped"')

      expect(embedded_svg('format-bold.svg', id: 'bold-text', config: toolbar_config('Bold Text')))
        .to include('id="bold-text"')

      expect(embedded_svg('format-bold.svg', id: 'bold-text', config: toolbar_config('Bold Text')))
        .to include('data-tooltip="Bold Text"')
    end

    it 'returns a standard svg icon' do
      expect(embedded_svg('format-bold.svg', class: 'test-class')).to include('class="test-class"')
    end

    it 'returns if no icon name is present' do
      expect(embedded_svg('')).to eq(nil)
    end
  end

end
