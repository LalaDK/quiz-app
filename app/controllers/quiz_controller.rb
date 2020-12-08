class QuizController < AdminApplicationController

  def index
    respond_to do |format|
      format.json do
        render json: Quiz.all
      end
    end
  end

  def create
    respond_to do |format|
      format.json do
        quiz = Quiz.new
        if quiz.save
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
        quiz = Quiz.find(params[:id])
        quiz.attributes = params_permit
        if quiz.save
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
        quiz = Quiz.find(params[:id])
        render json: quiz.as_json(
          include: {
            categories: { only: :_id }
          }
        )
      end
    end
  end

  def destroy
    respond_to do |format|
      format.json do
        quiz = Quiz.find(params[:id])
        if quiz.destroy
          render json: {}
        else
          raise
        end
      end
    end
  end

  def params_permit
    params.permit %i[name]
  end
end
