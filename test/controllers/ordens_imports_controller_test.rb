require 'test_helper'

class OrdensImportsControllerTest < ActionController::TestCase
  test "should get new_create" do
    get :new_create
    assert_response :success
  end

end
