class Quiz::Category::QuestionController < ApplicationController

  def show
    respond_to do |format|
      format.json do
        quiz = Quiz.find(params[:quiz_id])
        category = quiz.categories.find(params[:category_id])
        question = category.questions.find(params[:id])
        render json: question
      end
    end
  end
end
