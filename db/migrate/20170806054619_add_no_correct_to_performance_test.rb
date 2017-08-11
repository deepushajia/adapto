class AddNoCorrectToPerformanceTest < ActiveRecord::Migration[5.0]
  def change
    add_column :performance_tests, :no_correct, :integer
  end
end
