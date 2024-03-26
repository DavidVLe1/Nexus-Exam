# == Schema Information
#
# Table name: assembled_exam_questions
#
#  id                 :integer          not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  practice_exam_id   :integer          not null
#  question_choice_id :integer          not null
#  question_id        :integer          not null
#
# Indexes
#
#  index_assembled_exam_questions_on_practice_exam_id    (practice_exam_id)
#  index_assembled_exam_questions_on_question_choice_id  (question_choice_id)
#  index_assembled_exam_questions_on_question_id         (question_id)
#
# Foreign Keys
#
#  practice_exam_id    (practice_exam_id => practice_exams.id)
#  question_choice_id  (question_choice_id => question_choices.id)
#  question_id         (question_id => questions.id)
#
class AssembledExamQuestion < ApplicationRecord
  belongs_to :practice_exam
  belongs_to :question
  belongs_to :question_choice
end
