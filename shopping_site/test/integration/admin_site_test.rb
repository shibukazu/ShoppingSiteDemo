require 'test_helper'

class AdminSiteTest < ActionDispatch::IntegrationTest
  def setup
    @admin = Admin.new(email: "Example@test.com", password: "12345678", password_confirmation: "12345678")
    @master = Admin.new(email: "master@test.com", password: "12345678")
  end

  test "when access to signup should redirect root without login" do
    get new_admin_path
    assert_redirected_to root_url
  end

  test "when create admin user should redirect root without login" do
    post admins_path, params: { admin: { email: "test@test.com",
                                        password: "12345678",
                                        password_confirmation: "12345678" } }
    assert_redirected_to root_url
  end

  test "when access to index should redirect root without login" do
    get admins_path
    assert_redirected_to root_url
  end

  

  test "should redirect index page with login as admin" do
    log_in_as_admin(@master)
    get admins_path
    assert_template 'admins/index'
  end


end
