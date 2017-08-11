class Question < ApplicationRecord
  has_many :attempt_records
  has_many :options

  def self.mock_population
    course = Course.find_by(id:1)
    course.topics.each do |topic|
      x = 1
      5.times do
        q = Question.new
        q.question = "What the fuck is That!?"
        q.topic_id = topic.id
        q.active = true
        q.difficulty = x
        q.no_taken = 0
        q.no_correct = 0
        q.no_wrong = 0
        q.solution = "No Solution"
        q.save!
        option = 1
        4.times do
          o = Option.new
          o.question_id = q.id
          o.correct = (option == 3)
          o.no_selected = 0
          o.option = "Bah HUmbag no #{option}"
          o.save!
          option = option + 1
        end
        x = x + 1
      end
    end
  end

  def self.score(question_id,option)
    q = Option.find_by(question_id:question_id,option: option)
    if q.present? && q.correct
      return 1
    else
      return 0
    end
  end
end
