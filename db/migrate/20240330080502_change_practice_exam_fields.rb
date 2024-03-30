class ChangePracticeExamFields < ActiveRecord::Migration[7.0]
  def change
    change_column :practice_exams, :score, :float, null: true
    change_column :practice_exams, :end_time, :datetime, null: true
  end
end
