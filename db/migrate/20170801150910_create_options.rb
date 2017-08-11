class CreateOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :options do |t|
      t.integer :question_id
      t.boolean :correct
      t.text :option
      t.integer :no_selected

      t.timestamps
    end
  end
end
