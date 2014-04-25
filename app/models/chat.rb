class Chat < ActiveRecord::Base
  def broadcast!
    redis = Redis.new
    redis.publish(:chats, self.message)
  end
end
