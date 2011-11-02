require 'test_helper'

class PartyControllerTest < ActionController::TestCase
  test "should get orientation" do
    get :orientation
    assert_response :success
  end

  test "should get peep" do
    get :peep
    assert_response :success
  end

  test "should get peeps" do
    get :peeps
    assert_response :success
  end

end
