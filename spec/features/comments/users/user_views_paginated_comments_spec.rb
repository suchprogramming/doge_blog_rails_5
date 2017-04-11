require 'rails_helper'

RSpec.feature 'A user views paginated comments' do

  let(:user_post) { create(:current_user_post_comment_pack) }

  def user
    user_post.postable
  end

  before(:each) do
    login_as user, scope: :user

    visit user_post_path(user, user_post)
  end

  scenario 'with success' do
    expect(page).to have_selector('div', class: 'pagination')
  end
end
