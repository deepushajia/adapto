class AttemptRecord < ApplicationRecord
  belongs_to :question

  def self.submission_stages(payload,test_id,user_id,test_no)
    score_data_per_question = {}
    no_correct = 0
    no_wrong = 0
    no_unattempted = 0
    total_time_taken = 0
    payload.each do |data|
      ar = AttemptRecord.find_or_initialize_by(user_id:user_id,
                                               generated_test_id:test_id,
                                               question_id: data["question_id"])
      question = Question.find_by(id:data["question_id"])
      option = Option.find_by(question_id: ar.question_id, option: data["option"])
      if option.present?
        option.no_selected = option.no_selected.to_i + 1
        ar.option_id = option.id
        option.save!
      end
      ar.time_taken = data["time_taken"]
      total_time_taken = total_time_taken + data["time_taken"]
      ar.score = Question.score(data["question_id"],data["option"])
      if data[:option] != "NIL"
        if ar.score == 1
          no_correct = no_correct + 1
        else
          no_wrong = no_wrong + 1
        end
        attempted = true
      else
        no_unattempted = no_unattempted + 1
        attempted = false
      end
      score_data_per_question["#{question.topic_id}"] ||= []
      score_data_per_question["#{question.topic_id}"].push([ar.score,question.difficulty,attempted])
      ar.topic_id = question.topic_id
      ar.save!
    end
    PerformanceTest.proficiency_calculation(score_data_per_question,user_id,test_no)
    per_test = PerformanceTest.find_by(user_id:user_id,test_no:test_no)
    proficiency = PerformanceTopic.where(user_id: user_id,test_no:test_no).pluck(:proficiency) rescue [0]
    per_test.proficiency = proficiency.sum/proficiency.count
    per_test.no_correct = no_correct
    per_test.no_wrong = no_wrong
    per_test.no_unattempted = no_unattempted
    total_attempted = no_correct.to_i + no_wrong.to_i
    per_test.accuracy = (no_correct.to_f / total_attempted)*100
    per_test.save!
    average_time = total_time_taken.to_f/(no_wrong + no_correct + no_unattempted)
    return per_test, average_time, total_time_taken
  end

end
