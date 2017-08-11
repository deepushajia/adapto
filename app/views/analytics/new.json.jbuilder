if @user.blank?
  json.status_code 401
  json.message 'No User Found'
else
  json.status_code 200
  json.total_proficiency @total_proficiency
  json.total_accuracy @total_accuracy
  json.topic_proficiency @topic_proficiency
  json.topic_accuracy @topic_accuracy
  json.day_nos @day_no
end
