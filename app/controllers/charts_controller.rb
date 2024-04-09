class ChartsController < ApplicationController
  def index
    @chart_data = current_user.practice_exams.pluck(:end_time,:custom_max_num_questions, :score)
    @chart_data = @chart_data.reject { |data_point| data_point[2].nil? } # Filter out nil values
    @longer_practice_exams = @chart_data.select { |exam| exam[1] > 30 }
    @shorter_practice_exams = @chart_data.select { |exam| exam[1] <= 30 }
  end
end
