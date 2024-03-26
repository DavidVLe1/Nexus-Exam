json.extract! question, :id, :exam_id, :prompt, :created_at, :updated_at
json.url question_url(question, format: :json)
