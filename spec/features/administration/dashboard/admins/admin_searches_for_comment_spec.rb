require 'rails_helper'

RSpec.feature 'Admin searches for and manages a comment' do

  let(:admin) { create(:admin) }

  before(:each) do
    login_as admin, scope: :admin

    visit administration_dashboard_comments_path
  end

  scenario 'with success' do
  end

  scenario 'with no records found' do
  end
end
