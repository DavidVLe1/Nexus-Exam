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
  def to_meta_tags
    MetaTagService.defaults.deep_merge({
      title: "#{name} Exam",
      description: "#{max_duration} minutes and #{max_num_questions}",
    })
  end
  has_many :questions
  has_many :practice_exams
end
