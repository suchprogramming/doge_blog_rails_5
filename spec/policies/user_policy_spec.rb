require 'rails_helper'

describe UserPolicy do

  let(:current_user) { create(:user) }
  let(:alternate_user) { create(:alternate_user) }

  subject { UserPolicy }

  permissions :show? do
    it "allows you to view your own profile" do
      expect(subject).to permit(current_user, current_user)
    end

    it "allows you to view any user profile" do
      expect(subject).to permit(current_user, alternate_user)
    end
  end
end
