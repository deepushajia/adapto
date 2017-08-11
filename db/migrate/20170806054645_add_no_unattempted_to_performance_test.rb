class AddNoUnattemptedToPerformanceTest < ActiveRecord::Migration[5.0]
  def change
    add_column :performance_tests, :no_unattempted, :integer
  end
end
