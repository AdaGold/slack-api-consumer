class ChatController < ApplicationController
  def index
    @channels = SlackApiWrapper.list_channels
  end

  def new
    @channel = params[:channel]
  end

  def create
    success = SlackApiWrapper.send_msg(params[:channel], params[:message])
    if success
      flash[:status] = :success
      flash[:message] = "Message successfully sent"
    else
      flash[:status] = :error
      flash[:message] = "Error sending the message"
    end
    redirect_to root_path
  end
end
