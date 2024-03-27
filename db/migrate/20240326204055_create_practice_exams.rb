class CreatePracticeExams < ActiveRecord::Migration[7.0]
  def change
    create_table :practice_exams do |t|
      t.references :exam, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :custom_max_num_questions, null:false
      t.integer :custom_max_duration, null:false
      t.datetime :start_time, null:false
      t.datetime :end_time, null:false
      t.float :score, null:false

      t.timestamps
    end
  end
end
