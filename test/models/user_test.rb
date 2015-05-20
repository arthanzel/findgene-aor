require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should create and authenticate new users" do
    user = User.new(username: "new_user")
    user.password = "My Password"
    user.save!

    assert User.find_by_username("new_user").password == "My Password"
  end

  test "should authenticate existing users" do
    user = User.find_by_username("test_user")
    assert user.password == "my_password"
  end
end
