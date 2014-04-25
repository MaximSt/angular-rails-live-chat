class ChatsController < ApplicationController
  def create
    @chat = NewChatAction.new(params[:chat][:message])
    @chat.create!

    respond_to do |format|
      format.js
      format.html { redirect_to root_url }
    end
  end
end
