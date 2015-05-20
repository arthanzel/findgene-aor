require 'test_helper'

class AuthControllerTest < ActionController::TestCase
  test "should issue an access token on a login" do
    post :login, { username: "test_user", password: "my_password" }
    assert_equal 32, response.body.length
  end

  test "should send a 401 on a bad login" do
    post :login, { username: "test_user", password: "fake" }
    assert_equal 401, response.status

    post :login, { username: "fake", password: "fake" }
    assert_equal 401, response.status
  end

  test "should destroy an open token on logout" do
    post :login, { username: "test_user", password: "my_password" }
    token = response.body
    assert_equal 1, Access.count

    request.headers["Authorization"] = "Token #{ token }"
    post :logout
    assert_equal 204, response.status
    assert_equal 0, Access.count
  end

  test "should refuse access to a restricted action" do
    post :logout, { username: "test_user", password: "my_password" }
    assert_equal 401, response.status
    assert response.headers["WWW-Authenticate"]
  end
end
