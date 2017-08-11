class AddTopicIdToAttemptRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :attempt_records, :topic_id, :integer
  end
end
