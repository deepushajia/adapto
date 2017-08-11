class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.boolean :active
      t.string :name
      t.text :icon

      t.timestamps
    end
  end
end
