if @user.present? && !@question_data.blank?
  json.status_code 200
  json.day @day_no
  json.time @time
  json.questions @question_data
else
  json.status_code 401
  json.message @message
end
