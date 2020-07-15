require 'test_helper'

class UsersSessionControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get users_session_new_url
    assert_response :success
  end

  test "should get create" do
    get users_session_create_url
    assert_response :success
  end

  test "should get destroy" do
    get users_session_destroy_url
    assert_response :success
  end

end
