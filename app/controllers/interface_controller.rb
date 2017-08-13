class InterfaceController < ApplicationController
  skip_before_action :create_user

  def index
    course = Course.find_by(params[:course_id])
    @topics = course.topics.pluck(:name)
    @difficulty = [1,2,3,4,5]
    @success= Question.last.id rescue 1
    render "index.html.erb"
  end

  def show
    if params.present?
      q = Question.new
      q.question = params[:question]
      q.solution = params[:solution]
      q.active = true
      q.difficulty = params[:difficulty]
      topic = Topic.find_by(name: params[:topic])
      q.topic_id = topic.id
      q.no_correct = 0
      q.no_wrong = 0
      q.average_time = 0
      if q.save
        @success = q.id
      end
      x = 0
      [params[:coption],params[:woption1],params[:woption2],params[:woption3]].each do |option|
        o = Option.new
        o.question_id = q.id
        o.correct = true if x == 0
        o.option = option
        o.no_selected = 0
        o.save!
        x= x+1
      end
    end
    course = Course.find_by(params[:course_id])
    @topics = course.topics.pluck(:name)
    @difficulty = [1,2,3,4,5]
  end
end
