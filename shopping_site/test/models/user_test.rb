require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "kazuki", email: "Example@test.com", password: "1234567890", password_confirmation: "1234567890")
  end


  test "should be valid" do
    assert @user.valid?
  end

  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "password should be present" do
    @user.password = ""
    @user.password_confirmation = ""
    assert_not @user.valid?
  end


  test "password have words less than minimum should be rejected" do
    @user.password = "123456789"
    @user.password_confirmation = "123456789"
    assert_not @user.valid?
  end
end
