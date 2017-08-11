class AddOptionToOptions < ActiveRecord::Migration[5.0]
  def change
    add_column :options, :option, :text
  end
end
