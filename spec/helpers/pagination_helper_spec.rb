require 'rails_helper'

RSpec.describe PaginationHelper, :type => :helper do

  let(:comments) { build_list(:comment, 27, commentable: build(:user), post: build(:current_user_post)) }

  def first_comment
    comments.first
  end

  def last_comment
    comments.last
  end

  describe '#get_record_index' do
    it 'returns the page number for a record given a collection' do
      expect(get_record_index(comments, first_comment)).to eq(1)
      expect(get_record_index(comments, last_comment)).to eq(2)
    end
  end
end
