require 'rails_helper'
require 'will_paginate/array'

RSpec.describe PaginationHelper, :type => :helper do

  let(:user_list) { create_list(:user, 26) }

  describe '#paged_collection' do
    it 'returns a paginated collection based on a per page param' do
      expect(user_list.length).to eq(26)
      expect(paged_collection(user_list, 25).length).to eq(25)
      expect(paged_collection(user_list, 25).total_pages).to eq(2)
    end
  end
end
