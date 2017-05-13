class ConversationsController < ApplicationController
  before_action :authenticate_any_scope!

  def index
    @conversations = Conversation.my_conversations(current_any_scope)
  end

  def show
    @conversation = Conversation.find(params[:id])
    authorize @conversation
  end

  def create
    if Conversation.between(current_any_scope, receivable).any?
      @conversation = Conversation.between(current_any_scope, receivable).first
      authorize @conversation
    else
      @conversation = Conversation.create!(conversation_params)
      authorize @conversation
    end

    redirect_to new_conversation_message_path(@conversation)
  end

  private

  def conversation_params
    params.require(:conversation).permit(:receivable_id, :receivable_type).merge(sendable: current_any_scope)
  end

  def receivable
    if params[:conversation][:receivable_type] == 'User'
      User.find(params[:conversation][:receivable_id])
    elsif params[:conversation][:receivable_type] == 'Admin'
      Admin.find(params[:conversation][:receivable_id])
    end
  end
end
