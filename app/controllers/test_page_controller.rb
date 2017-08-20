class TestPageController < ApplicationController

  def create
    submission_payload = params[:submission]
      test_performance = PerformanceTest.find_or_create_by(user_id: @user.id,test_no: params[:test_no])
      @per_test, @average_time, @total_time = AttemptRecord.submission_stages(submission_payload,test_performance.id,@user.id, params[:test_no])
      @prof_per_topic = {}
      Course.first.topics.each do |topic|
        pt = PerformanceTopic.where(user_id:@user.id,topic_id:topic.id).order(:test_no).last(2)
        @prof_per_topic["#{topic.name}"] ||= {}
        if pt.count == 2
          @prof_per_topic["#{topic.name}"][:previous] = pt.first.proficiency
          @prof_per_topic["#{topic.name}"][:current] = pt.last.proficiency
        else
          @prof_per_topic["#{topic.name}"][:previous] = 0.0
          @prof_per_topic["#{topic.name}"][:current] = pt.last.proficiency
        end
      end
  end

  def new
    course = Course.find_by(id: params[:course_id])
    topics = course.topics
    no_of_questions = params[:questions_needed].to_i
    questions_per_topic = (no_of_questions/topics.count).to_i
    @question_data = []
    test_no = User.day_calculation(@user.id)
    @day_no = test_no
    @time = 1800
    generated_test = GeneratedTest.find_by(user_id:@user.id,test_no:test_no)
    unless generated_test.present?
      generated_test = GeneratedTest.create({user_id:@user.id,test_no:test_no})
      topics.each do |topic|
          proficiency = PerformanceTopic.where(user_id:@user.id,topic_id:topic.id).order(:test_no).last.proficiency.to_i rescue 0
          difficulty = ((proficiency/2) + 1).to_i
          available_questions = Question.where(topic_id: topic.id,difficulty: difficulty).pluck(:id)
          attempted_questions = AttemptRecord.where(user_id:@user.id, topic_id: topic.id).pluck(:question_id) rescue 0
          permitted_questions = (available_questions - attempted_questions).sample(questions_per_topic)
          if topic.id == topics.last.id
            if (@question_data.count + permitted_questions.count) < no_of_questions
              questions_per_topic = no_of_questions - @question_data.count
              permitted_questions = (available_questions - attempted_questions).sample(questions_per_topic)
            end
          end
          Question.where(id: permitted_questions).each do |question|
            questions_data = {}
            questions_data[:question_id] = question.id
            GeneratedTestQuestion.create({generated_test_id:generated_test.id,question_id: question.id})
            questions_data[:question] = question.question
            order = Array.new(question.options.count){ |i| (i+1) }
            question.options.each do |opt|
              x = order.sample
              questions_data["option_#{x}"] = opt.option
              order = order - [x]
            end
            question.no_taken = question.no_taken.to_i + 1
            question.save!
            @question_data.push(questions_data)
          end
      end
    else
      unless PerformanceTest.where(user_id:@user.id,test_no:test_no).present?
        permitted_questions = generated_test.generated_test_questions.pluck(:question_id)
        Question.where(id: permitted_questions).each do |question|
          questions_data = {}
          questions_data[:question_id] = question.id
          questions_data[:question] = question.question
          order = Array.new(question.options.count){ |i| (i+1) }
          question.options.each do |opt|
            x = order.sample
            questions_data["option_#{x}"] = opt.option
            order = order - [x]
          end
          @question_data.push(questions_data)
        end
      else
        @message = "This test was taken today. Try again tomorrow!"
      end
    end
    generated_test = GeneratedTest.find_by(user_id:@user.id,test_no:test_no)
    if @user.email == "ammu@gmail.com" || @user.email == "test@dec.com"
      @question_data = []
      unless generated_test.present?
        generated_test = GeneratedTest.create({user_id:@user.id,test_no:test_no})
      topics.each do |topic|
        available_questions = Question.where(topic_id: topic.id).pluck(:id)
        attempted_questions = AttemptRecord.where(user_id:@user.id, topic_id: topic.id).pluck(:question_id) rescue 0
        permitted_questions = (available_questions - attempted_questions).sample(questions_per_topic)
        if topic.id == topics.last.id
          if (@question_data.count + permitted_questions.count) < no_of_questions
            questions_per_topic = no_of_questions - @question_data.count
            permitted_questions = (available_questions - attempted_questions).sample(questions_per_topic)
          end
        end
        Question.where(id: permitted_questions).each do |question|
          questions_data = {}
          questions_data[:question_id] = question.id
          GeneratedTestQuestion.create({generated_test_id:generated_test.id,question_id: question.id})
          questions_data[:question] = question.question
          order = Array.new(question.options.count){ |i| (i+1) }
          question.options.each do |opt|
            x = order.sample
            questions_data["option_#{x}"] = opt.option
            order = order - [x]
          end
          question.no_taken = question.no_taken.to_i + 1
          question.save!
          @question_data.push(questions_data)
        end
      end

    else
      unless PerformanceTest.where(user_id:@user.id,test_no:test_no).present?
        permitted_questions = generated_test.generated_test_questions.pluck(:question_id)
        Question.where(id: permitted_questions).each do |question|
          questions_data = {}
          questions_data[:question_id] = question.id
          questions_data[:question] = question.question
          order = Array.new(question.options.count){ |i| (i+1) }
          question.options.each do |opt|
            x = order.sample
            questions_data["option_#{x}"] = opt.option
            order = order - [x]
          end
          @question_data.push(questions_data)
        end
      else
        @message = "This test was taken today. Try again tomorrow!"
      end
    end
    end
  end
end
