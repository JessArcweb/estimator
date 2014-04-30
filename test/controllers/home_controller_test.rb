require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get inde" do
    get :inde
    assert_response :success
  end

end
