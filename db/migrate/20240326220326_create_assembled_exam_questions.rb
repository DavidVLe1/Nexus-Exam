class CreateAssembledExamQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :assembled_exam_questions do |t|
      t.references :practice_exam, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :question_choice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
