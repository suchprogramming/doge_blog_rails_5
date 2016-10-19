require 'rails_helper'

describe PostPolicy do

  let(:current_user) { create(:user) }
  let(:second_user) { create(:user, email: 'second_user@test.com') }
  let(:current_user_post) { create(:post, user: current_user) }

  subject { PostPolicy }

  permissions :new?, :create?, :update?, :edit?, :destroy? do
    it "denies access if a user does not own a post resource" do
      expect(subject).not_to permit(second_user, current_user_post)
    end

    it "grants access if ownership can be verified" do
      expect(subject).to permit(current_user, current_user_post)
    end
  end
end
