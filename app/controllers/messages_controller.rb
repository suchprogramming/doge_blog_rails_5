class MessagesController < ApplicationController
  before_action :authenticate_any_scope!

  def new
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.new(messageable: messageable)
  end

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.new(message_params)
    if @message.save
      redirect_to conversation_path(@conversation), notice: 'Message Sent!'
    else
      render :new
    end
  end

  private

  def messageable
    return User.find(params[:user_id]) if params[:user_id]
    return Admin.find(params[:admin_id]) if params[:admin_id]
  end

  def message_params
    params.require(:message).permit(:text).merge(messageable: messageable)
  end
end
