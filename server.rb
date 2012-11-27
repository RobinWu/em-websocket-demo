require 'rubygems'
require 'eventmachine'
require 'em-websocket'

@sockets = []
EventMachine.run do
  EventMachine::WebSocket.start(:host => '0.0.0.0', :port => 8080) do |ws|
    ws.onopen do
      puts "Have new ws: #{ws}"
      @sockets << ws
    end

    ws.onmessage do |msg|
      puts msg
      @sockets.each { |s| s.send msg }
    end

    ws.onclose do
      puts "Have close ws: #{ws}"
      @sockets.delete ws
    end
  end
end
