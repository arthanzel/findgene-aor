require 'json'
require 'test_helper'

class PrimersControllerTest < ActionController::TestCase
  setup do
    a = Access.create!()
    request.headers["Authorization"] = "Token #{ a.token }"
  end

  test "index action should return all primers" do
    get :index
    assert_equal 200, response.status
    assert_equal 101, json.length
    assert_equal "A01", json[0]["code"]
  end

  test "show action should show one primer" do
    get :show, { id: Primer.find_by_code("M01").id }
    assert_equal 200, response.status
    assert_equal "Martin's Primer", json["name"]

    get :show, { id: "Does not exist" }
    assert_equal 404, response.status
  end

  test "create action should create a primer" do
    #TODO: add validation
    post :create, {
      primer: {
        name: "Hanzel's Primer",
        code: "H01",
        sequence: "tataaat"
      }
    }
    assert_equal 201, response.status
    assert_equal json["code"], "H01"
    assert_equal 102, Primer.count
    assert_equal "tataaat", Primer.find_by_code("H01").sequence

    post :create, {
      primer: {
        name: "Hanzel's Primer",
        code: "M01",
        sequence: "tataaat"
      }
    }
    assert_equal 409, response.status
  end

  test "update action should update a primer" do
    # TODO: add validation
    put :update, {
      id: Primer.find_by_code("M01").id,
      primer: {
        name: "Martin's Updated Primer",
        code: "M02"
      }
    }
    assert_equal 200, response.status
    assert_equal "Martin's Updated Primer", json["name"]
    assert_equal "gattaca", Primer.find_by_code("M02").sequence
    assert_nil Primer.find_by_code("M01")

    put :update, { id: "Does not exist", primer: { name: "Does nothing" } }
    assert_equal 404, response.status

    put :update, { id: Primer.find_by_code("M02"), primer: { code: "A01" } }
    assert_equal 409, response.status
    assert_equal Primer.find_by_code("M02").name, "Martin's Updated Primer"
    assert_not_equal Primer.find_by_code("A01").name, "Martin's Updated Primer"
  end

  test "destroy action should destroy a primer" do
    delete :destroy, { id: Primer.find_by_code("M01").id }
    assert_equal 204, response.status
    assert_equal 100, Primer.count
    assert_nil Primer.find_by_code("M01")

    delete :destroy, { id: "Does not exist" }
    assert_equal 404, @response.status
  end

  def json
    JSON.parse(@response.body)
  end
end
