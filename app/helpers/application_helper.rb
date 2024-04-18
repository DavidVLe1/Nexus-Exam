module ApplicationHelper
  def default_meta_tags
    {
      site: "Nexus Exam",
      image: image_url('meta_tag_nexus_exam.jpg'),
      description: "Practice for IT Certification Exams",
      og: {
        title: "Nexus Exam",
        image: image_url('meta_tag_nexus_exam.jpg'),
        description: "Practice for IT Certification Exams",
        site_name: "Nexus Exam"
      }
      # TODO: add twitter tags
    }
  end
end
