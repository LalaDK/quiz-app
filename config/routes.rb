Rails.application.routes.draw do

  resources :game, controller: 'game', only: %i[index create show update destroy] do
    put 'show_answer', controller: 'game', action: 'show_answer'
    put 'start_game', controller: 'game', action: 'start_game'
    put 'assign_points_to/:team_id', controller: 'game', action: 'assign_points_to'
    put 'open_question/:question_id', controller: 'game', action: 'open_question'
    put 'close_question/:question_id', controller: 'game', action: 'close_question'
    resources :team, controller: 'game/team', only: %i[index create show update destroy]
  end


  resources :quiz, controller: 'quiz', only: %i[index create show update destroy] do
    resources :category, controller: 'quiz/category', only: %i[show create update destroy] do
      resources :question, controller: 'quiz/category/question', only: %i[create show update destroy]
    end
  end
  get 'admin', to: 'admin#index'
  root to: 'viewer#index'
end
