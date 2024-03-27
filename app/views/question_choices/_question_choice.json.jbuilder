json.extract! question_choice, :id, :response, :is_correct, :question_id, :created_at, :updated_at
json.url question_choice_url(question_choice, format: :json)
