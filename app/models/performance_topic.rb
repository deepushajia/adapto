class PerformanceTopic < ApplicationRecord
  belongs_to :user

  def self.create_topics(user_id,course_id)
    course = Course.find_by(id: course_id)
    topics = course.topics
    topics.each do |topic|
      pt = PerformanceTopic.new
      pt.user_id = user_id
      pt.topic_id = topic.id
      pt.accuracy = 0.0
      pt.proficiency = 0.0
      pt.save!
    end
  end
end
