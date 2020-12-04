class Quiz
  include Mongoid::Document
  store_in collection: 'quizzes'

  field :name, type: String
  field :is_deleted, type: Boolean

  has_many :categories, class_name: '::Category'
end
