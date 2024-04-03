Rails.application.routes.draw do
  get '/practice/:id', to: 'exams#practice', as: 'practice'
  post '/exam_submission', to: 'practice_exams#submit_practice', as: 'exam_submission'
  resources :assembled_exam_questions
  resources :practice_exams, except: [ :destroy] do
    member do
      post 'start_practice'
      post 'submit_practice'
    end
  end

  # Restricting these routes by commenting.
  #resources :question_choices 
  #resources :questions
  
  get 'landing/index'
  root "landing#index"
  resources :exams do
    post 'start_practice', on: :member
  end
  devise_for :users
end
