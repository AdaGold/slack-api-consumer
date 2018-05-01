class ChatController < ApplicationController
  def index
  end

  def new
    @channel = params[:channel]
  end

  def create
  end
end
