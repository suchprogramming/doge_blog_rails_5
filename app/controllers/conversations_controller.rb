class ConversationsController < ApplicationController
  before_action :authenticate_any_scope!
  before_action :set_conversation_context, only: [:update]

  def index
    @conversations = Conversation.my_conversations(current_any_scope)
  end

  def show
    @conversation = Conversation.my_conversations(current_any_scope).find(params[:id])
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

  def update
    @conversation = Conversation.find(params[:id])
    authorize @conversation
    if @conversation.update(permitted_attributes(@conversation))
      redirect_to conversations_path, success: 'Conversation Deleted!'
    else
      render :index
    end
  end

  private

  def conversation_params
    params.require(:conversation).permit(params_list).merge(sendable: current_any_scope)
  end

  def params_list
    [
      :receivable_id,
      :receivable_type,
      :sendable_active,
      :sendable_offset,
      :receivable_active,
      :receivable_offset
    ]
  end

  def receivable
    if params[:conversation][:receivable_type] == 'User'
      User.find(params[:conversation][:receivable_id])
    elsif params[:conversation][:receivable_type] == 'Admin'
      Admin.find(params[:conversation][:receivable_id])
    end
  end

  def set_conversation_context
    current_any_scope ? current_any_scope.conversation_context = params[:conversation] : nil
  end
end
