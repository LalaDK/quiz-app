class Quiz::Category::QuestionController < ApplicationController

  def create
    respond_to do |format|
      format.json do
        quiz = Quiz.find(params[:quiz_id])
        category = quiz.categories.find(params[:category_id])
        question = Question.new(category: category)
        if question.save
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
        category = quiz.categories.find(params[:category_id])
        question = category.questions.find(params[:id])
        question.attributes = params_permit
        if question.save
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
        quiz = Quiz.find(params[:quiz_id])
        category = quiz.categories.find(params[:category_id])
        question = category.questions.find(params[:id])
        render json: question
      end
    end
  end

  def destroy
    respond_to do |format|
      format.json do
        quiz = Quiz.find(params[:quiz_id])
        category = quiz.categories.find(params[:category_id])
        question = category.questions.find(params[:id])
        if question.destroy
          render json: {}
        else
          render json: question
        end
      end
    end
  end

  def params_permit
    params.permit %i[question answer reward spotify_uri]
  end
end
