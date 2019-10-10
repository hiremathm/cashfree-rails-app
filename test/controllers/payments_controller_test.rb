require 'test_helper'

class PaymentsControllerTest < ActionController::TestCase
  test "should get request" do
    get :request
    assert_response :success
  end

  test "should get response" do
    get :response
    assert_response :success
  end

  test "should get home" do
    get :home
    assert_response :success
  end

end
