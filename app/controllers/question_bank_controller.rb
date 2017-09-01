class QuestionBankController < ApplicationController

  def new
    course = Course.find_by(id: params[:course_id])
    @question_topic_list = []
    generated_test = GeneratedTest.where(user_id:@user.id).pluck(:id) rescue nil
    generated_test_questions = GeneratedTestQuestion.where(generated_test_id:generated_test).pluck(:question_id) rescue nil
    questions = Question.where(id: generated_test_questions) rescue nil
    course.topics.each do |topic|
      total_questions = questions.where(topic_id:topic.id).count rescue 0
      hash = {}
      hash[:id] = topic.id
      hash[:name] = topic.name
      hash[:total_questions] = total_questions
      @question_topic_list.push(hash)
    end
  end

  def display
    @topic = Topic.find_by(id: params[:topic_id])
    generated_test = GeneratedTest.where(user_id:@user.id).pluck(:id) rescue nil
    generated_test_questions = GeneratedTestQuestion.where(generated_test_id:generated_test).pluck(:question_id) rescue nil
    questions = Question.where(id: generated_test_questions,topic_id:@topic) rescue nil
    @question_data = []
    questions.each do |question|
      hash = {}
      hash[:id] = question.id
      hash[:question] = question.question
      hash[:options] = []
      question.options.each do |opt|
        options = {}
        options[:id] = opt.id
        options[:option] = opt.option
        options[:correct] = opt.correct
        hash[:options].push(options)
      end
      user_attempt = question.attempt_records.where(user_id:@user.id).last
      if user_attempt.present?
        hash[:time_taken] = user_attempt.time_taken
        if user_attempt.option_id.present?
           if user_attempt.score == 1
             hash[:attempted] = "C"
             hash[:correct] = true
           else
             hash[:attempted] = "W"
             hash[:incorrect] = true
           end
        else
          hash[:attempted] = "N"
          hash[:unattempted] = true
        end
        hash[:bookmarked] = false
      end
      @question_data.push(hash)
    end
  end
end
