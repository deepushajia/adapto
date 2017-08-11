class CreateGeneratedTests < ActiveRecord::Migration[5.0]
  def change
    create_table :generated_tests do |t|
      t.integer :user_id
      t.integer :test_no

      t.timestamps
    end
  end
end
