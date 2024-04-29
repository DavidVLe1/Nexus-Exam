class ChartsController < ApplicationController
  include AuthenticationConcern
  def index
    aws_exam_name = "AWS Cloud Practitioner"
    @aws_exam = Exam.find_by(name: aws_exam_name)
    @breadcrumbs = [
      { content: "Home", href: root_path },
      { content: "Charts", href: charts_path}
    ]
    if @aws_exam
      @chart_data = filter_chart_data(current_user.practice_exams.where(exam_id: @aws_exam.id))
      @longer_practice_exams, @shorter_practice_exams = split_chart_data(@chart_data)
    else
      flash[:alert] = "AWS Cloud Practitioner exam not found"
      redirect_to root_path
    end
  end

  private

  def filter_chart_data(data)
    data.pluck(:end_time, :custom_max_num_questions, :score)
        .reject { |data_point| data_point[2].nil? }
        .map { |data_point| format_data_point(data_point) }
  end

  def format_data_point(data_point)
    [data_point[0].strftime("%-m/%-d/%y %I:%M %p"), data_point[1], data_point[2]]
  end

  def split_chart_data(data)
    data.partition { |exam| exam[1] > 30 }
  end
end
