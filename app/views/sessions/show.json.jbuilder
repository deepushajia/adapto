if @user.blank?
  json.status_code 401
  json.message 'No User Found'
else
  if @data.blank?
    json.status_code 401
    json.message 'Wrong Password'
  else
    json.status_code 200
    json.message 'Success'
    json.data @data
  end
end
