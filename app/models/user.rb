class User < ApplicationRecord
  has_many :courses
  has_many :performance_topics

  def self.day_calculation(user_id)
    user = User.find_by(id:user_id)
    date_of_join = Date.parse(user.created_at.strftime('%F'))
    present_date = Date.parse(Time.now.strftime('%F'))
    day_number = (present_date - date_of_join).to_i
    return day_number
  end
end
