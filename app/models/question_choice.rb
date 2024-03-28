# == Schema Information
#
# Table name: question_choices
#
#  id          :integer          not null, primary key
#  is_correct  :boolean          not null
#  response    :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer          not null
#
# Indexes
#
#  index_question_choices_on_question_id  (question_id)
#
# Foreign Keys
#
#  question_id  (question_id => questions.id)
#
class QuestionChoice < ApplicationRecord
  belongs_to :question

  has_many :assembled_exam_questions
end
