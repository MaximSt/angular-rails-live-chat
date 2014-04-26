module PubSub
  extend ActiveSupport::Concern
  
  included do
    def broadcast!
      self.class.pubsub_redis.publish(:chats, self.pubsubdata)
    end
  end

  module ClassMethods
    @pubsub_redis

    def pubsub_redis
      @pubsub_redis.call()
    end

    def pubsub &block
      @pubsub_redis = Proc.new do
        yield block
      end
    end

    def subscribe(&block)
      self.pubsub_redis.subscribe :chats, &block
    end
  end
end
