class AddNotNullConstraintToQuestionsPrompt < ActiveRecord::Migration[7.0]
  def change
    change_column_null :questions, :prompt, false
  end
end
