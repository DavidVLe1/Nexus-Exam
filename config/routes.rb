Rails.application.routes.draw do
  get '/practice/:id', to: 'exams#practice', as: 'practice'
  post '/exam_submission', to: 'practice_exams#submit_practice', as: 'exam_submission'
  resources :assembled_exam_questions
  resources :practice_exams do
    member do
      post 'start_practice'
      post 'submit_practice'
    end
  end
  resources :question_choices
  resources :questions
  get 'landing/index'
  root "landing#index"
  resources :exams do
    post 'start_practice', on: :member
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
