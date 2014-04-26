module PubSub
  extend ActiveSupport::Concern
  
  included do
    def broadcast!
      self.class.publish_from(self)
    end
  end

  module ClassMethods
    def pubsub_redis
      @redis_method.call
    end

    def pubsub_source &blk
      @redis_method = blk
    end

    def pubsub_data method
      @pubsub_data_method = method
    end

    def pubsub_channel channel
      @channel = channel
    end

    def subscribe(&block)
      self.pubsub_redis.subscribe @channel, &block
    end

    def publish_from source
      self.pubsub_redis.publish(@channel, source.send(@pubsub_data_method))
    end
  end
end
