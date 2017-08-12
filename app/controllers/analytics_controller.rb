class AnalyticsController < ApplicationController

  def new
    course = Course.find_by(id:params[:course_id])
    performance_test = PerformanceTest.where(user_id: @user.id).order(:test_no)
    days = performance_test.pluck(:test_no)
    @day_no = days.collect{|i| i.to_s}
    @day_no = [0] if @day_no.blank?
    @total_accuracy = performance_test.pluck(:accuracy)
    @total_accuracy = [0] if @total_accuracy.blank?
    @total_proficiency = performance_test.pluck(:proficiency)
    @total_proficiency = [0] if @total_proficiency.blank?
    @topic_accuracy = {}
    @topic_proficiency = {}
    course.topics.each do |topic|
      performance_topic = PerformanceTopic.where(user_id: @user.id,topic_id: topic.id).order(:test_no)
      @topic_accuracy["#{topic.name}"] = performance_topic.pluck(:accuracy)
      @topic_proficiency["#{topic.name}"] = performance_topic.pluck(:proficiency)
    end
  end

  def get_current
    performance_test = PerformanceTest.where(user_id: @user.id).order(:test_no).last
    topic_id = Course.find_by(id:params[:course_id]).topics.pluck(:id)
    performance_topic = PerformanceTopic.where(user_id: @user.id,topic_id: topic_id, test_no: performance_test.test_no).pluck(:accuracy) rescue nil
    @proficiency = performance_test.proficiency rescue 0
    @accuracy = (performance_topic.sum.to_f/performance_topic.count) rescue 0
    @day_no = User.day_calculation(@user.id) rescue 1
  end
end
