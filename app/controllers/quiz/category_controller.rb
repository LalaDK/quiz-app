class Quiz::CategoryController < ApplicationController

  def show
    respond_to do |format|
      format.json do
        quiz = Quiz.find(params[:quiz_id])
        category = quiz.categories.find(params[:id])
        render json: category.as_json(
          include: {
            questions: { only: :_id }
          }
        )
      end
    end
  end
end
