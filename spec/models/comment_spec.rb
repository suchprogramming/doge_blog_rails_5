require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:commentable) }
  it { should belong_to(:post) }
  it { should validate_presence_of(:text) }

  describe '#page_num' do

    let(:comment_list) { create(:current_user_post_comment_pack).comments }

    it 'returns the page number for a given paginated comment' do
      expect(comment_list.length).to eq(26)
      expect(comment_list.first.page_num).to eq(1)
      expect(comment_list.last.page_num).to eq(2)
    end
  end
end
