module Exam::MetaTaggable
  extend ActiveSupport::Concern

  include ApplicationHelper # we need this so we can extend default meta tags

  def to_meta_tags
    exam_tags = {
      title: "Nexus Exam",
      description: "#{max_duration} minutes and #{max_num_questions}",
      og: {
        title: "#{name} Exam",
        description: "#{max_duration} minutes and #{max_num_questions}",
        site_name: "Nexus Exam",
      },
    }

    exam_tags
  end
end
