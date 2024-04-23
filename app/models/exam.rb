# == Schema Information
#
# Table name: exams
#
#  id                :integer          not null, primary key
#  max_duration      :integer
#  max_num_questions :integer
#  name              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Exam < ApplicationRecord
  include MetaTaggable

  has_many :questions
  has_many :practice_exams

  def start_practice_for_user(user, quiz_length)
    max_duration = quiz_length == 10 ? 15 : 90
    Time.zone = "Central Time (US & Canada)"

    practice_exam = PracticeExam.create(
      exam: self,
      user: user,
      custom_max_num_questions: quiz_length,
      custom_max_duration: max_duration,
      start_time: Time.zone.now,
    )

    PracticeExamAssembler.assemble(practice_exam)
    practice_exam
  end
end
