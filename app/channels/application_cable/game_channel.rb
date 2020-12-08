module ApplicationCable
  class GameChannel < ApplicationCable::Channel

    def subscribed
      game = Game.where(pin_code: params[:pin_code]).first
      if game.nil?
        reject
      else
        stream_from game.id
        ActionCable.server.broadcast(game.id, game.json)
      end
    end

    def receive(data)
    end
  end
end
