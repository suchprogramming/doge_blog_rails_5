module ConversationsHelper
  def contextual_avatar(user_scope = nil, conversation = nil)
    return unless user_scope && conversation

    if user_scope == conversation.sendable
      render_user_avatar(conversation.receivable, :thumb)
    elsif user_scope == conversation.receivable
      render_user_avatar(conversation.sendable, :thumb)
    end
  end

  def contextual_name(user_scope = nil, conversation = nil)
    return unless user_scope && conversation

    if user_scope == conversation.sendable
      conversation.receivable.name
    elsif user_scope == conversation.receivable
      conversation.sendable.name
    end
  end

  def delete_conversation(user_scope = nil, conversation = nil)
    return unless user_scope && conversation

    button_to 'Delete', conversation_path(conversation),
              params: delete_params(user_scope, conversation),
              method: :patch
  end

  def delete_params(user_scope = nil, conversation = nil)
    return unless user_scope && conversation

    if user_scope == conversation.sendable
      {
        conversation: {
          sendable_active: false, sendable_offset: conversation.message_offset
        }
      }
    elsif user_scope == conversation.receivable
      {
        conversation: {
          receivable_active: false, receivable_offset: conversation.message_offset
        }
      }
    end
  end
end
