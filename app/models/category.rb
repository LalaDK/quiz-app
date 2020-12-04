class Category
  include Mongoid::Document
  store_in collection: 'categories'

  belongs_to :quiz, class_name: 'Quiz'
  has_many :questions, class_name: 'Question'

  field :background_color, type: String
  field :name, type: String, default: '(Unavngivet)'

  before_save do
    self.background_color = "##{SecureRandom.hex(3)}" if background_color.blank?
  end

  def font_color
    return "#FFFFFF" if background_color.blank?

    color_str = background_color.delete('#')
    r = color_str[0..1].hex
    g = color_str[2..3].hex
    b = color_str[4..5].hex
    if (r.to_f * 0.299 + g.to_f * 0.587 + b.to_f * 0.114) > 186
      "#000000"
    else
      "#FFFFFF"
    end
  end
end
