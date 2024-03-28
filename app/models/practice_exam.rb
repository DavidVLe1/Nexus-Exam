# == Schema Information
#
# Table name: practice_exams
#
#  id                       :integer          not null, primary key
#  custom_max_duration      :integer          not null
#  custom_max_num_questions :integer          not null
#  end_time                 :datetime         not null
#  score                    :float            not null
#  start_time               :datetime         not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  exam_id                  :integer          not null
#  user_id                  :integer          not null
#
# Indexes
#
#  index_practice_exams_on_exam_id  (exam_id)
#  index_practice_exams_on_user_id  (user_id)
#
# Foreign Keys
#
#  exam_id  (exam_id => exams.id)
#  user_id  (user_id => users.id)
#
class PracticeExam < ApplicationRecord
  belongs_to :exam
  belongs_to :user

  has_many :assembled_exam_questions
end
