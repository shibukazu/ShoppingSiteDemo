require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  def setup
    @admin = Admin.new(email: "Example@test.com", password: "1234567890", password_confirmation: "1234567890")
  end


  test "should be valid" do
    
    assert @admin.valid?
  end

  test "email should be present" do
    @admin.email = ""
    assert_not @admin.valid?
  end

  test "password should be present" do
    @admin.password = ""
    @admin.password_confirmation = ""
    assert_not @admin.valid?
  end


  test "password have words less than minimum should be rejected" do
    @admin.password = "1234"
    @admin.password_confirmation = "1234"
    assert_not @admin.valid?
  end

  
end
