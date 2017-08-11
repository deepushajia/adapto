class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.integer :course_id
      t.boolean :active
      t.string :name
      t.text :icon

      t.timestamps
    end
  end
end
