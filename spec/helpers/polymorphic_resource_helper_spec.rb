require 'rails_helper'

RSpec.describe PolymorphicResourceHelper, :type => :helper do

  let(:post) { create(:post_with_user) }

  describe "#polymorphic_owner?" do
    it "returns true if the given user or admin is the owner of a polymorphic resource" do
      post_owner = post.postable

      expect(post_owner.polymorphic_owner?(post)).to eq(true)
    end

    it "returns false when a user or admin does not own a resource" do
      non_post_owner = User.new

      expect(non_post_owner.polymorphic_owner?(post)).to eq(false)
    end

    it "returns false for object receivers that do not return their polymorphic parent" do
      dummy_user = User.new
      non_polymorphic_receiver = OpenStruct.new

      expect(dummy_user.polymorphic_owner?(non_polymorphic_receiver)).to eq(false)
    end
  end
end
