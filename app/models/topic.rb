class Topic < ApplicationRecord
  belongs_to :course

  def self.mock_population(array,course_id)
    array.each do |name|
      topic = Topic.new
      topic.active = true
      topic.course_id = course_id
      topic.save!
    end
  end
end
