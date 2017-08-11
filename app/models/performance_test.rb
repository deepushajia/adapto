class PerformanceTest < ApplicationRecord

  def self.proficiency_calculation(score_data_per_question,user_id,test_no)
    keys = score_data_per_question.keys
    keys.each do |key|
      t_num_sum = 0
      total_seen = 0
      t_acc_num_sum = 0
      t_acc_den_sum = 0
      score_data_per_question["#{key}"].each do |topic_wise_data|
        score = topic_wise_data[0].to_i
        difficulty = topic_wise_data[1].to_i
        attempted = topic_wise_data[2]
        #<proficiency>#
        t_num_sum = t_num_sum + score*difficulty
        #</proficiency>#
        #<accuracy>#
        if attempted
          t_acc_num_sum = t_acc_num_sum + score
          t_acc_den_sum = t_acc_den_sum + 1
        end
        total_seen = total_seen + 1
        #</accuracy>#
      end
      t_acc_den_sum = 1  if t_acc_den_sum == 0
      last_per_topic = PerformanceTopic.where(user_id:user_id,topic_id:key).order(:test_no).last(10) rescue nil
      per_topic = PerformanceTopic.find_or_initialize_by(user_id:user_id,topic_id:key,test_no:test_no)
      if last_per_topic.present?
        latest_per_topic = last_per_topic.last
        if last_per_topic.count == 9
          last_9_total_seen = latest_per_topic.total_seen.to_i - last_per_topic.first.total_seen.to_i
          last_9_total_attempted = latest_per_topic.total_attempted.to_i - last_per_topic.first.total_attempted.to_i
        else
          last_9_total_seen = latest_per_topic.total_seen.to_i
          last_9_total_attempted = latest_per_topic.total_attempted.to_i
        end
        proficiency = (latest_per_topic.proficiency.to_f*last_9_total_seen + (t_num_sum.to_f / (total_seen*5))*(10*total_seen))/(last_9_total_seen + total_seen)
        accuracy = (latest_per_topic.accuracy.to_f*last_9_total_attempted + (t_acc_num_sum.to_f)*100)/(last_9_total_attempted + t_acc_den_sum)

        per_topic.total_seen = last_9_total_seen + total_seen
        per_topic.total_attempted = last_9_total_attempted + t_acc_den_sum
        per_topic.proficiency = proficiency
        per_topic.accuracy = accuracy
        per_topic.save!
      else
        proficiency = (t_num_sum.to_f/(total_seen*5))*10
        accuracy = (t_acc_num_sum.to_f / t_acc_den_sum)*100

        per_topic.total_seen = total_seen
        per_topic.total_attempted = t_acc_den_sum
        per_topic.proficiency = proficiency
        per_topic.accuracy = accuracy
        per_topic.save!
      end
    end

  end
end
