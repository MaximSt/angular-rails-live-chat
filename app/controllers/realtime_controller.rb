class RealtimeController < ActionController::Base
  include ActionController::Live

  def stream
    response.headers['Content-Type'] = 'text/event-stream'
    sse = SSE.new(response.stream, id: 2, retry: 300, event: 'message')
    Chat.subscribe do |on|
      on.message do |channel, message|
        sse.write({ :message => message })
      end
    end
  ensure
    sse.close
  end

  # private
  # def sse(object, options={})
  #   (options.map{|k,v| "#{k}: #{v}" } << "data: #{JSON.dump object}").join("\n") + "\n\n"
  # end
end
