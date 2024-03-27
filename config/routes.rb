Rails.application.routes.draw do
  resources :assembled_exam_questions
  resources :practice_exams
  resources :question_choices
  resources :questions
  get 'landing/index'
  root "landing#index"
  resources :exams
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
