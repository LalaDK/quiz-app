class Quiz::Category::QuestionController < AdminApplicationController

  def create
    respond_to do |format|
      format.json do
        quiz = Quiz.find(params[:quiz_id])
        category = quiz.categories.find(params[:category_id])
        question = Question.new({
          category: category,
          question: "Hvad er Quizzy?",
          answer: "Et dejligt quizprogram!",
          links: [{link: 'https://www.quizzy.dk/', name: 'www.quizzy.dk'}]
          })
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
      params.permit [ :question, :answer, :reward, links: [:name, :link] ]
    end
  end
