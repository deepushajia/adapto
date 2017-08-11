if @user.blank?
  json.status_code 401
  json.message 'No User Found'
else
  json.status_code 200
  json.test_no @per_test.test_no
  json.no_wrong @per_test.no_wrong
  json.no_correct @per_test.no_correct
  json.no_unattempted @per_test.no_unattempted
  json.average_time @average_time
  json.total_time @total_time
  json.performance_topics @prof_per_topic
end
