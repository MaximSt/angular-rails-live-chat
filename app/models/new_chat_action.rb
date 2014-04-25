class NewChatAction < Struct.new(:message)
  def create!
    chat = Chat.new(:message => message)
    chat.save!
    chat.broadcast!
    chat
  end
end
