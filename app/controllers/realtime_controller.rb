class RealtimeController < ActionController::Base
  include ActionController::Live

  def stream
    response.headers['Content-Type'] = 'text/event-stream'
    Redis.new.subscribe :chats do |on|
      on.message do |channel, message|
        # let's ignore channel for now
        response.stream.write sse(:message => message)
      end
    end
  ensure
    response.stream.close
  end

  private
  def sse(object, options={})
    (options.map{|k,v| "#{k}: #{v}" } << "data: #{JSON.dump object}").join("\n") + "\n\n"
  end
end
