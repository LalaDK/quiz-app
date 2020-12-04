Rails.application.routes.draw do

  resources :quiz, controller: 'quiz', only: %i[index show update destroy] do
    resources :category, controller: 'quiz/category', only: %i[show create update destroy] do
      resources :question, controller: 'quiz/category/question', only: %i[create show update destroy]
    end
  end
  root to: 'home#index'
end
