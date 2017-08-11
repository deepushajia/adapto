class CreatePerformanceTests < ActiveRecord::Migration[5.0]
  def change
    create_table :performance_tests do |t|
      t.integer :user_id
      t.integer :test_no
      t.float :proficiency
      t.float :accuracy

      t.timestamps
    end
  end
end
