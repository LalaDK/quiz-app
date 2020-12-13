class Game::Question
  include Mongoid::Document

  field :question, type: String
  field :answer, type: String
  field :reward, type: Integer, default: 100
  field :links, type: Array, default: []
  field :team_id, type: BSON::ObjectId
  field :skipped, type: Boolean

  embedded_in :category, class_name: '::Game::Category'

  def answered
    !self.team_id.nil?
  end
end
