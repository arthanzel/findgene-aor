require 'test_helper'

class AuthControllerTest < ActionController::TestCase
  test "should validate users" do
    get :index
    assert_equal 404, response.status

    request.headers["X-FindGene-Auth"] = "fake/fake"
    get :index
    assert_equal 404, response.status

    request.headers["X-FindGene-Auth"] = "test_user/my_password"
    get :index
    assert_equal 200, response.status
  end
end
