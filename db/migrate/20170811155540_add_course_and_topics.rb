class AddCourseAndTopics < ActiveRecord::Migration[5.0]
  def change
    c = Course.new
    c.name  = "Quantitative Aptitude"
    c.active = true
    c.save!
    ["Number System","Arithmetic","Modern Maths","Geometry","Algebra"].each do |name|
      t = Topic.new
      t.name = name
      t.active = true
      t.course_id = c.id
      t.save!
    end
  end
end
