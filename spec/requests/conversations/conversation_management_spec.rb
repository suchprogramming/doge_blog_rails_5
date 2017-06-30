require 'rails_helper'

RSpec.describe 'Conversation management', :type => :request do

  let(:conversation) { create(:conversation) }
  let(:user) { create(:user) }

  def sender
    conversation.sendable
  end

  def recipient
    conversation.receivable
  end

  def conversation_params
    {
      conversation: {
        receivable_id: recipient.id,
        receivable_type: recipient.class.to_s
      }
    }
  end

  def deactivate_params
    {
      conversation: {
        sendable_active: false,
        sendable_offset: conversation.message_offset
      }
    }
  end

  context 'on the CONVERSATION #index route' do
    it 'allows a user to visit their message inbox as a sender' do
      login_as sender, scope: :user

      get conversations_path

      expect(response).to be_success
      expect(response.body).to include('Inbox')
      expect(response.body).to include(conversation.receivable.name)
    end

    it 'allows a user to visit their message inbox as a receiver' do
      login_as recipient, scope: :user

      get conversations_path

      expect(response).to be_success
      expect(response.body).to include('Inbox')
      expect(response.body).to include(conversation.sendable.name)
    end

    it 'redirects unauthenticated requests' do
      get conversations_path

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'on the CONVERSATION #show route' do
    it 'allows a user to visit a specific conversation as a sender' do
      login_as sender, scope: :user

      get conversation_path(conversation)

      expect(response).to be_success
      expect(response.body).to include("Conversation with #{conversation.receivable.name}")
    end

    it 'allows a user to visit a specific conversation as a receiver' do
      login_as recipient, scope: :user

      get conversation_path(conversation)

      expect(response).to be_success
      expect(response.body).to include("Conversation with #{conversation.sendable.name}")
    end

    it 'redirects unauthenticated requests' do
      get conversation_path(conversation)

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'on the CONVERSATION #create route' do
    it 'allows a user to create a new conversation' do
      login_as sender, scope: :user

      Conversation.destroy_all

      post conversations_path, params: conversation_params
      follow_redirect!

      expect(response.body).to include('New Message')
    end

    it 'allows a user to continue an existing conversation' do
      login_as sender, scope: :user

      post conversations_path, params: conversation_params

      expect(response).to redirect_to(new_conversation_message_path(conversation))
      follow_redirect!

      expect(response.body).to  include('New Message')
    end

    it 'redirects unauthenticated requests' do
      post conversations_path, params: conversation_params

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'on the CONVERSATION #update route' do
    it 'allows a user to delete(deactivate) a conversation' do
      login_as sender, scope: :user

      patch conversation_path(conversation), params: deactivate_params

      expect(response).to redirect_to(conversations_path)
      follow_redirect!

      expect(response.body).to include('Inbox')
      expect(response.body).not_to include("#{conversation.receivable.name}")
    end

    it 'prevents a receiver from deleting(deactivating) an sender conversation' do
      login_as recipient, scope: :user

      patch conversation_path(conversation), params: deactivate_params

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(default_pundit_error)
    end

    it 'redirects unauthenticated requests' do
      patch conversation_path(conversation), params: conversation_params

      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
