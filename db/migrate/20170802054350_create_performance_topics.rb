class CreatePerformanceTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :performance_topics do |t|
      t.integer :user_id
      t.integer :topic_id
      t.integer :test_no
      t.float :proficiency
      t.float :accuracy

      t.timestamps
    end
  end
end
