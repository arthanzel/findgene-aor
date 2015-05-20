require "bcrypt"

class User < ActiveRecord::Base
  has_one :access

  # Returns BCrypt's Password object based on the hash
  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  # Sets a new Password with a random salt
  def password=(new_pass)
    @password = BCrypt::Password.create(new_pass)
    self.password_hash = @password
  end

  def self.authenticate(username, pass)
    user = find_by_username(username)
    if user and user.password == pass
      user
    else
      nil
    end
  end
end
