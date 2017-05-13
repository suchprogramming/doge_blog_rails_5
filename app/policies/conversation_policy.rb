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
end
