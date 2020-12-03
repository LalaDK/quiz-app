class Question
  include Mongoid::Document
  store_in collection: 'questions'

  belongs_to :category, class_name: 'Category'

  field :question, type: String
  field :answer, type: String
  field :reward, type: Integer, default: 100
  field :spotify_uri, type: String
  field :skipped, type: Boolean
end
