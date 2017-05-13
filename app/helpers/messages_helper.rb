module MessagesHelper
  def new_message_link(user_scope = nil, receivable = nil)
    return unless user_scope && receivable
    return if user_scope == receivable

    link_to 'Send Message', conversations_path(message_params(receivable)), method: :post
  end

  def message_params(receivable = nil)
    return unless receivable

    {
      conversation: {
        receivable_id: receivable.id,
        receivable_type: receivable.class.to_s
      }
    }
  end
end
