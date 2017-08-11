class CreateGeneratedTestQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :generated_test_questions do |t|
      t.integer :generated_test_id
      t.integer :question_id

      t.timestamps
    end
  end
end
