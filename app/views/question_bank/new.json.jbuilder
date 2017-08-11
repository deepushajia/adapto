if @user.blank?
  json.status_code 401
  json.message 'No User Found'
else
  json.status_code 200
  json.question_topic_list @question_topic_list
end
