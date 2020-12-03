class Category
  include Mongoid::Document
  store_in collection: 'categories'

  belongs_to :quiz, class_name: 'Quiz'
  has_many :questions, class_name: 'Question'

  field :name, type: String
end
