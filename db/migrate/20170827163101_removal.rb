class Removal < ActiveRecord::Migration[5.0]
  def change
    User.all.destroy_all
    AttemptRecord.all.destroy_all
    GeneratedTest.all.destroy_all
    GeneratedTestQuestion.all.destroy_all
    PerformanceTest.all.destroy_all
    PerformanceTopic.all.destroy_all
  end
end
