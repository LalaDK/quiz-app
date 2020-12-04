class QuizController < ApplicationController

  def index
    respond_to do |format|
      format.json do
        render json: Quiz.all
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
end
