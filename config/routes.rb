Rails.application.routes.draw do
  authenticate :user, ->(user) { user.admin? } do
    mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  end

  get "charts/index"
  # Could use better naming? Not sure what the difference is between exams#practice and practice_exams and exams and assembled_exam_questions
  get "/practice/:id", to: "exams#practice", as: "practice"
  post "/exam_submission", to: "practice_exams#submit_practice", as: "exam_submission"

  resources :practice_exams, except: [:destroy] do
    member do
      post "start_practice"
      post "submit_practice"
    end
  end
  get "/charts", to: "charts#index"
  get "/landing", to: "landing#index", as: "landing"
  root "landing#index"

  resources :exams, except: [:destroy], path: "exam" do
    post "start_practice", on: :member
  end
  resources :assembled_exam_questions
  resources :question_choices
  resources :questions
  devise_for :users
end
