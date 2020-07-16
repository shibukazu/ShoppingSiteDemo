require 'test_helper'

class OrdersAdminControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get orders_admin_index_url
    assert_response :success
  end

  test "should get show" do
    get orders_admin_show_url
    assert_response :success
  end

end
