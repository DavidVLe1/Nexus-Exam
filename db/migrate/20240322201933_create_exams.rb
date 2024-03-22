class CreateExams < ActiveRecord::Migration[7.0]
  def change
    create_table :exams do |t|
      t.string :name
      t.integer :max_num_questions
      t.integer :max_duration

      t.timestamps
    end
  end
end
