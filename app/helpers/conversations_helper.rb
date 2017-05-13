module ConversationsHelper
  def contextual_avatar(user_scope = nil, conversation = nil)
    return unless user_scope && conversation

    if user_scope == conversation.sendable
      render_user_avatar(conversation.receivable, :thumb)
    else
      render_user_avatar(conversation.sendable, :thumb)
    end
  end

  def contextual_name(user_scope = nil, conversation = nil)
    return unless user_scope && conversation

    if user_scope == conversation.sendable
      conversation.receivable.name
    else
      conversation.sendable.name
    end
  end
end
