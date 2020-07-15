require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test1)
    @invalid_user = User.new(email: "Example@test.com", password: "1234567890")
  end
  test "should be made session with valid login" do
    post users_session_create_path, params: { email: @user.email,
                                              password: "1234567890" }
    assert_not session[:user_id].nil?
  end

  test "should not be made session with invalid login" do
    post users_session_create_path, params: { email: @invalid_user.email,
                                              password: "1234567890" }
    assert session[:user_id].nil?
  end

  test "should be deleted session when logout" do
    post users_session_create_path, params: { email: @user.email,
                                              password: "1234567890" }
    assert_not session[:user_id].nil?
    get users_session_destroy_path
    assert session[:user_id].nil?
  end
end       
