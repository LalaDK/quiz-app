class Quiz
  include Mongoid::Document
  store_in collection: 'quizzes'

  field :name, type: String
  field :is_deleted, type: Boolean
  belongs_to :user, class_name: 'User'

  has_many :categories, class_name: '::Category'
end
