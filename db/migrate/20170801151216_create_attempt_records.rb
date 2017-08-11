class CreateAttemptRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :attempt_records do |t|
      t.integer :user_id
      t.integer :question_id
      t.integer :option_id
      t.integer :topic_id
      t.integer :score
      t.integer :time_taken
      t.integer :generated_test_id

      t.timestamps
    end
  end
end
