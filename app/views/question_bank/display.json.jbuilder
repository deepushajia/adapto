if @user.blank?
  json.status_code 401
  json.message 'No User Found'
else
  json.status_code 200
  if @question_data.blank?
    json.message 'No Questions'
  else
    json.message 'Success'
    json.topic_name @topic.name
    json.question_data @question_data
  end
end
