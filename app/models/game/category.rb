class Game::Category
  include Mongoid::Document

  field :name, type: String

  embeds_many :questions, class_name: 'Game::Question', cascade_callbacks: true
  embedded_in :game, class_name: '::Game'
end
