require 'test_helper'

class AdminsSessionControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admins_session_new_url
    assert_response :success
  end

  test "should get create" do
    get admins_session_create_url
    assert_response :success
  end

end
