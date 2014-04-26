class Chat < ActiveRecord::Base
  include PubSub

  pubsub { Redis.new }

  def pubsubdata
    message
  end
end
