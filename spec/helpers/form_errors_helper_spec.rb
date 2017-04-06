require 'rails_helper'

RSpec.describe FormErrorsHelper, :type => :helper do

  let(:user) { User.new }

  describe '#field_class' do
    it 'returns the field error css class when errors are present' do
      user.errors.add(:email, "can't be blank")

      expect(field_class(user, :email)).to eq('field-errors')
    end

    it 'returns a blank string when no errors are present' do
      expect(field_class(user, :email)).to eq('')
    end
  end

  describe '#show_errors' do
    it 'returns the first error message from failed AR validations' do
      user.errors.add(:email, "can't be blank!")
      user.errors.add(:current_password, 'weeeeeeeeee!')

      expect(show_errors(user, :email)).to eq("can't be blank!")
    end

    it 'returns nil when no errors are present' do
      expect(show_errors(user, :email)).to eq(nil)
    end
  end
end
