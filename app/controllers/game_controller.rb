class GameController < AdminApplicationController

  def index
    respond_to do |format|
      format.json do
        render json: Game.where(user: current_user).all
      end
    end
  end

  def create
    respond_to do |format|
      format.json do
        game = Game.new
        game.user = current_user
        quiz = Quiz.find(params[:quiz_id])
        game.load_quiz(quiz)
        if game.save
          render json: {}
        else
          raise
        end
      end
    end
  end

  def show
    respond_to do |format|
      format.json do
        render json: Game.find(params[:id]).as_json(
          include: {
            categories: {
              methods: :font_color
            }
          },
          methods: %i[current_question current_team score_board ended questions_left]
        )
      end
    end
  end

  def show_answer
    respond_to do |format|
      format.any do
        game = Game.find(params[:game_id])
        game.show_answer = true
        if game.save
          render json: {}
        else
          raise
        end
      end
    end
  end

  def start_game
    respond_to do |format|
      format.any do
        game = Game.find(params[:game_id])
        game.start_game
        if game.save
          render json: {}
        else
          raise
        end
      end
    end
  end

  def open_question
    respond_to do |format|
      format.any do
        game = Game.find(params[:game_id])
        game.current_question_id = params[:question_id]
        if game.save
          render json: {}
        else
          raise
        end
      end
    end
  end

  def close_question
    respond_to do |format|
      format.any do
        game = Game.find(params[:game_id])
        game.current_question_id = nil
        game.show_answer = nil
        if game.save
          render json: {}
        else
          raise
        end
      end
    end
  end

  def assign_points_to
    respond_to do |format|
      format.any do
        game = Game.find(params[:game_id])
        game.award_points(params[:team_id])
        if game.save
          render json: {}
        else
          raise
        end
      end
    end
  end


  def update
    respond_to do |format|
      format.json do
        game = Game.find(params[:id])
        game.attributes = params_permit
        if game.save
          render json: {}
        else
          raise
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      format.json do
        game = Game.find(params[:id])
        if game.destroy
          render json: {}
        else
          raise
        end
      end
    end
  end
end
