class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.references :exam, null: false, foreign_key: true
      t.string :prompt

      t.timestamps
    end
  end
end
