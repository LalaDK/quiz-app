module ApplicationCable
  class QuizChannel < ApplicationCable::Channel

    def subscribed
      stream_from "stream"
    end

    def receive(data)
      ActionCable.server.broadcast("stream", data)
    end
  end
end
