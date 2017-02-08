require 'rails_helper'

RSpec.describe SvgIconHelper, :type => :helper do

  def sweet_options
    {
      pos: 'right',
      text: 'Happy Trees',
      class: 'some class',
      id: 'unique id'
    }
  end

  def link_fixture
    "<img
      data-position=\"right\"
      data-delay=\"300\"
      data-tooltip=\"Happy Trees\"
      class=\"some class\"
      id=\"unique id\"
      src=\"/images/testing\"
      alt=\"Testing\"
    />".gsub("\n", " ").squeeze(" ")
  end

  def default_link_fixture
    "<img
      data-position=\"bottom\"
      data-delay=\"300\"
      data-tooltip=\"Missing Text\"
      class=\"tooltipped\"
      src=\"/images/testing\"
      alt=\"Testing\"
    />".gsub("\n", " ").squeeze(" ")
  end

  def options_fixture
    {
      data: {
        position: "right",
        delay: 300,
        tooltip: "Happy Trees"
      },
      class: "some class",
      id: "unique id"
    }
  end

  describe '#render_icon' do
    it 'returns an image link when valid arguments are present' do
      expect(render_icon('testing', sweet_options)).to eq(link_fixture)
    end

    it 'returns default parameters when no options hash is present' do
      expect(render_icon('testing')).to eq(default_link_fixture)
    end

    it 'returns if no icon name is present' do
      expect(render_icon('')).to eq(nil)
    end
  end

  describe '#icon_options' do
    it 'returns a hash of options if valid keys are present' do
      expect(icon_options(sweet_options)).to eq(options_fixture)
    end
    it 'returns if no options are present' do
      expect(icon_options(nil)).to eq(nil)
    end
  end
end
