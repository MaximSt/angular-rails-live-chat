class Chat < ActiveRecord::Base
  include PubSub

  pubsub_source do
    Redis.new
  end

  pubsub_data :get_pubsub_data
  pubsub_channel "chats"

  def get_pubsub_data
    self.message
  end
end
