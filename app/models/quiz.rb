class Quiz
  include Mongoid::Document
  store_in collection: 'quizzes'

  has_many :categories, class_name: 'Category'

  field :name, type: String
end
