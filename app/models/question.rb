# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  prompt     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  exam_id    :integer          not null
#
# Indexes
#
#  index_questions_on_exam_id  (exam_id)
#
# Foreign Keys
#
#  exam_id  (exam_id => exams.id)
#
class Question < ApplicationRecord
  belongs_to :exam
  validates :prompt, uniqueness: { case_sensitive: false }

  has_many :assembled_exam_questions
end
