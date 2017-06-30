class ConversationPolicy
  attr_reader :user, :conversation

  def initialize(user, conversation)
    @user = user
    @conversation = conversation
  end

  def show?
    create?
  end

  def create?
    @user == @conversation.sendable || @user == @conversation.receivable
  end

  def update?
    if @user == @conversation.sendable
      @user.conversation_context.try(:keys) == sendable_attrs
    elsif @user == @conversation.receivable
      @user.conversation_context.try(:keys) == receivable_attrs
    end
  end

  def permitted_attributes
    if @user == @conversation.sendable
      sendable_attrs
    elsif @user == @conversation.receivable
      receivable_attrs
    end
  end

  def sendable_attrs
    ['sendable_active', 'sendable_offset']
  end

  def receivable_attrs
    ['receivable_active', 'receivable_offset']
  end
end
