class Game
  include Mongoid::Document
  store_in collection: 'games'
  field :created_at, type: DateTime, default: DateTime.now

  field :lock_game, type: Boolean
  field :pin_code, type: String
  field :quiz_name, type: String
  field :current_team_id, type: BSON::ObjectId
  field :current_question_id, type: BSON::ObjectId

  embeds_many :teams, class_name: '::Game::Team', cascade_callbacks: true
  embeds_many :categories, class_name: '::Game::Category', cascade_callbacks: true

  validates :pin_code, uniqueness: { scope: :user }

  before_save do
    if self.pin_code.blank?
    self.pin_code = SecureRandom.random_number(9999).to_s.rjust(4, "0")
      while Game.where(pin_code: self.pin_code).exists?
        self.pin_code = SecureRandom.random_number(9999).to_s.rjust(4, "0")
      end
    end
  end

  def start_game
    self.lock_game = true
    next_team
  end

  def questions_left
    categories.map(&:questions).to_a.flatten.select do |question|
      !question.skipped && question.team_id.blank?
    end.count
  end

  def add_team(name, background_color=nil)
    return if lock_game.true?

    teams << Game::Team.new(name: name, background_color: background_color)
  end

  def remove_team(team_id)
    return if lock_game.true?

    teams.find(team_id).destroy
  end

  def current_team
    return if self.current_team_id.nil?

    teams.find(self.current_team_id)
  end

  def current_question
    return if self.current_question_id.nil?

    categories.map(&:questions).flatten.find do |question|
      question.id == self.current_question_id
    end
  end

  def award_points(team_id)
    if team_id.nil? || team_id == 'null'
      skip_question()
      return
    end

    question = current_question()
    question.team_id = current_team_id
    question.save
    self.current_question_id = nil
    self.save
  end

  def skip_question
    return if current_question_id.nil?

    question = current_question()
    question.team_id = nil
    question.skipped = true
    question.save
  end

  def next_team
    return if teams.empty?

    if current_team_id.nil?
      self.current_team_id = teams.first.id
      return
    end

    return if teams.length < 2

    idx = teams.to_a.find_index { |team| team.id == current_team_id }

    if idx < teams.length - 1
      self.current_team_id = teams.to_a[idx + 1].id
    else
      self.current_team_id = teams.first.id
    end

    current_team
  end

  def points_by_team_id(team_id)
    count = 0
    categories.each do |category|
      category.questions.each do |question|
        count += 1 if question.team_id == team_id
      end
    end
    count
  end

  def score_board
    teams.map do |team|
      {name: team.name, points: points_by_team_id(team.id)}
    end
  end

  def ended
    categories.map(&:questions).flatten.all? { |question| question.skipped || !question.team_id.blank? }
  end

  def load_quiz(quiz)
    self.quiz_name = quiz.name
    self.categories = quiz.categories.map do |c|
      category = Game::Category.new(name: c.name, background_color: c.background_color)
      category.questions = c.questions.map do |q|
        Game::Question.new(
          question: q.question,
          answer: q.answer,
          reward: q.reward,
          spotify_uri: q.spotify_uri
        )
      end
      category
    end
  end
end
