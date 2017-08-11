class AddTotalAttemptedToPerformanceTopic < ActiveRecord::Migration[5.0]
  def change
    add_column :performance_topics, :total_attempted, :integer
  end
end
