class Game::Team
  include Mongoid::Document

  field :name, type: String
  field :color, type: String

  before_save do
    self.color = "##{SecureRandom.hex(3)}" if color.blank?
  end

  embedded_in :game, class_name: '::Game'
end
