require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.new(first_name: "test", family_name: "test", email: "Example@example.com", password: "1234567890", password_confirmation: "1234567890")
    @invalid_user = User.new(name: "test2", email: "Test")
  end

  test "should increase user with valid information" do
    assert_difference "User.count", 1 do
      post users_path, params: { user: { first_name: @user.first_name,
                                        family_name: @user.family_name,
                                        email: @user.email,
                                        password: @user.password,
                                        password_confirmation: @user.password_confirmation } }
    end
    assert_redirected_to root_url
  end

  test "should not increase user with invalid information" do
    assert_no_difference "User.count" do
      post users_path, params: { user: { name: @invalid_user.name,
        email: @invalid_user.email } }
    end
    assert_template 'users/new'
  end
end
