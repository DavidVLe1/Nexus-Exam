json.extract! practice_exam, :id, :exam_id, :user_id, :custom_max_num_questions, :custom_max_duration, :start_time, :end_time, :score, :created_at, :updated_at
json.url practice_exam_url(practice_exam, format: :json)
