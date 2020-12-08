class Quiz::CategoryController < AdminApplicationController

  def show
    respond_to do |format|
      format.json do
        quiz = Quiz.find(params[:quiz_id])
        category = quiz.categories.find(params[:id])
        render json: category.as_json(
          include: {
            questions: {}
          },
          methods: :font_color
        )
      end
    end
  end

  def create
    respond_to do |format|
      format.json do
        quiz = Quiz.find(params[:quiz_id])
        category = Category.new(quiz: quiz)
        if category.save
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
        quiz = Quiz.find(params[:quiz_id])
        category = quiz.categories.find(params[:id])
        category.attributes = params_permit
        if category.save
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
        quiz = Quiz.find(params[:quiz_id])
        category = quiz.categories.find(params[:id])
        if category.destroy
          render json: {}
        else
          raise
        end
      end
    end
  end

  def params_permit
    params.permit %i[background_color name is_deleted]
  end
end
