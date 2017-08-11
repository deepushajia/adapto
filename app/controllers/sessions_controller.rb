class SessionsController < ApplicationController

  def show
     email = params[:email]
     password = params[:password]
     @user = User.find_by(email: email)
     if @user.present?
       bcrypt   = ::BCrypt::Password.new(@user.hash_password)
       password = ::BCrypt::Engine.hash_secret(password, bcrypt.salt)
       valid = Devise.secure_compare(password, @user.hash_password)
       @data = {}
       if valid
         @data[:token] = @user.authentication_token
         @data[:name] = @user.full_name
         @data[:percentile] = "blank"
         @data[:proficiency] = "screw"
       end
     end
  end

  def create
    email = params[:email]
    password = params[:password]
    name = params[:name]
    pepper = nil
    cost = 10
    hash_create = ::BCrypt::Password.create("#{password}#{pepper}", :cost => cost).to_s
    token = Devise.friendly_token
    @user = User.create({email: email,
                         full_name: name,
                         hash_password: hash_create,
                         authentication_token: token})
    if @user.present?
        course_id = params[:course_id]
        PerformanceTopic.create_topics(@user.id,course_id)
        @data = {}
        @data[:token] = @user.authentication_token
        @data[:name] = @user.full_name
        @data[:percentile] = "blank"
        @data[:proficiency] = "screw"
    end
  end
end
