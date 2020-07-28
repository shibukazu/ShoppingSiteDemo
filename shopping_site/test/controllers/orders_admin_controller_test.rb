require 'test_helper'

class OrdersAdminControllerTest < ActionDispatch::IntegrationTest
    def setup
        @user = users(:test1)
        @admin = Admin.new(email: "master@test.com", password: "1234567890")
        @order = Order.new(user_id: @user.id, status: 0)
        @order.items << items(:Test1)
        @order.save
    end

    test "should be able to see admin's order table with valid login" do
        log_in_as_admin(@admin)
        get orders_admin_index_path
        assert_template 'orders_admin/index'
    end

    test "should not be able to see admin's order table without valid login" do
        get orders_admin_index_path
        assert_redirected_to root_path
    end


    test "should be able to see order's detail with valid login" do
        log_in_as_admin(@admin)
        get orders_admin_show_path, params: {order_id: @order.id}
        assert_template "orders_admin/show"
    end

    test "should not be able to order's detail page without valid login" do
        get orders_admin_show_path, params: {order_id: @order.id}
        assert_redirected_to root_path
    end

    test "should be able to change order's status with valid login" do
        log_in_as_admin(@admin)
        patch orders_admin_update_path(order_id: @order.id), params: {status: 1}
        @order.reload
        assert @order.status == 1
    end

    test "should not be able to change order's status without valid login" do
        patch orders_admin_update_path(order_id: @order.id), params: {status: 1}
        @order.reload
        assert_not @order.status == 1
    end

    test "should not be able to rollback order's status" do
        log_in_as_admin(@admin)
        patch orders_admin_update_path(order_id: @order.id), params: {status: 1}
        @order.reload
        assert @order.status == 1
        patch orders_admin_update_path(order_id: @order.id), params: {status: 0}
        @order.reload
        assert_not @order.status == 0
    end
    
    

end
