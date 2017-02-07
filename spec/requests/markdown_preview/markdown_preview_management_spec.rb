require 'rails_helper'

RSpec.describe 'MarkdownPreview management', :type => :request do

  let(:user) { create(:user) }
  let(:preview_params) { { post_content: '## Test' } }

  context 'on the MarkdownPreview#create route' do
    it 'allows authenticated users to preview a post' do
      login_as user, scope: :user

      post markdown_preview_path, params: preview_params
      expect(response).to be_success
    end

    it 'redirects unauthenticated users' do
      post markdown_preview_path, params: preview_params

      expect(response).to redirect_to new_user_session_path
    end
  end
end
