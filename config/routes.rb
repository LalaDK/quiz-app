Rails.application.routes.draw do

  resources :quiz, controller: 'quiz', only: %i[index show update destroy] do
    resources :category, controller: 'quiz/category', only: %i[show update destroy] do
      resources :question, controller: 'quiz/category/question', only: %i[show update destroy]
    end
  end
  root to: 'home#index'
end
