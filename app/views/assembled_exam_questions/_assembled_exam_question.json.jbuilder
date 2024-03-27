json.extract! assembled_exam_question, :id, :practice_exam_id, :question_id, :question_choice_id, :created_at, :updated_at
json.url assembled_exam_question_url(assembled_exam_question, format: :json)
