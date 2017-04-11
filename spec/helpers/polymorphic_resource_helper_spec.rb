require 'rails_helper'

RSpec.describe PolymorphicResourceHelper, :type => :helper do

  let(:post) { create(:current_user_post) }

  describe '#polymorphic_owner?' do
    it 'returns true if the given user or admin is the owner of a polymorphic resource' do
      expect(post.postable.polymorphic_owner?(post)).to eq(true)
    end

    it 'returns false when a user or admin does not own a resource' do
      expect(User.new.polymorphic_owner?(post)).to eq(false)
    end

    it 'returns false for object receivers that do not return their polymorphic parent' do
      non_polymorphic_receiver = OpenStruct.new

      expect(User.new.polymorphic_owner?(non_polymorphic_receiver)).to eq(false)
    end
  end
end
