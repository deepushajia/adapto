class AddNoWrongToPerformanceTest < ActiveRecord::Migration[5.0]
  def change
    add_column :performance_tests, :no_wrong, :integer
  end
end
