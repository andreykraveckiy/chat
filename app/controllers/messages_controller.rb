class MessagesController < ApplicationController
  def create
    @conversation = Conversation.includes(:recipient).find(params[:conversation_id])
    unless message_params[:body].blank?
      @message = @conversation.messages.create(message_params)
    else
      redirect_to controller: :home, action: :index
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :body)
  end
end
