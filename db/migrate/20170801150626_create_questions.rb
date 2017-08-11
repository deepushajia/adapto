class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.integer :topic_id
      t.boolean :active
      t.text :question
      t.integer :difficulty
      t.integer :no_taken
      t.integer :no_correct
      t.integer :no_wrong
      t.integer :average_time
      t.text :solution

      t.timestamps
    end
  end
end
