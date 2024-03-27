class CreateQuestionChoices < ActiveRecord::Migration[7.0]
  def change
    create_table :question_choices do |t|
      t.string :response, null: false
      t.boolean :is_correct, null: false
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
