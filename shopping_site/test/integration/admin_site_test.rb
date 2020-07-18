require 'test_helper'

class AdminSiteTest < ActionDispatch::IntegrationTest
  def setup
    @admin = Admin.new(email: "Example@test.com", password: "1234567890", password_confirmation: "1234567890")
    @master = Admin.new(email: "master@test.com", password: "1234567890")
    @user = users(:test1)
    @item = items(:Test1)
    orders.each do |order|
      order.items << @item
      @user.orders << order
    end
    @status_hash = { "0": "入金待ち", "1": "発送待ち", "2": "発送完了" }
  end

  test "when access to signup should redirect root without login" do
    get new_admin_path
    assert_redirected_to root_url
  end

  test "when create admin user should redirect root without login" do
    post admins_path, params: { admin: { email: "test@test.com",
                                        password: "1234567890",
                                        password_confirmation: "1234567890" } }
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

  test "user's orders history" do
    #注文一覧ページ関するテスト
    log_in_as_admin(@master)
    get admins_path
    assert_match orders_admin_index_path, response.body
    get orders_admin_index_path
    orders = Order.all
    orders.each do |order|
      assert_select "td", text: order.items.first.name + "などのご注文"
      assert_select "td", text: order.created_at.to_s
      assert_select "td", text: @status_hash[order.status.to_s.to_sym]
    end
    #status変更に関するテスト
    patch orders_admin_update_path(order_id: @user.orders.first.id), params: {status: 1}
    get orders_admin_index_path
    assert_match @status_hash[:"1"], response.body, count: 1
    #注文詳細ページに関するテスト
    user_order = @user.orders.first
    get orders_admin_show_path(order_id: user_order.id)
    assert_match @status_hash[user_order.status.to_s.to_sym], response.body
    sum = 0
    user_order.items.each do |item|
      assert_select "td", text: item.name
      assert_select "td", text: item.price.to_s
      sum += item.price
    end
    assert_match sum.to_s, response.body
    assert_match user_order.user.name, response.body
    assert_match user_order.user.email, response.body
    #ステータス変更ボタンに関するテスト
    assert_select "form select[name=?]", "status"
    assert_select "input[value=?]", "変更する" 
    #ステータス変更時、前のステータスに戻せないことに関するテスト
    patch orders_admin_update_path(order_id: @user.orders.first.id), params: {status: 0}
    get orders_admin_index_path
    assert_match @status_hash[:"1"], response.body, count: 1
    #2まで進めたらステータス変更ボタンが出ないことに関するテスト
    patch orders_admin_update_path(order_id: @user.orders.first.id), params: {status: 2}
    get orders_admin_index_path
    assert_match @status_hash[:"2"], response.body, count: 1
    assert_select "form select[name=?]", "status", count: 0
  end

  test "non-admin user can't chnage status" do
    user_order = @user.orders.first
    patch orders_admin_update_path(order_id: user_order.id), params: {status: 1}
    user_order.reload
    assert_not user_order.status == 1
    log_in_as_admin(@master)
    patch orders_admin_update_path(order_id: user_order.id), params: {status: 1}
    user_order.reload
    assert user_order.status == 1
  end

  test "cant rollback status" do
    user_order = @user.orders.first
    log_in_as_admin(@master)
    patch orders_admin_update_path(order_id: user_order.id), params: {status: 1}
    user_order.reload
    assert user_order.status == 1
    patch orders_admin_update_path(order_id: user_order.id), params: {status: 0}
    user_order.reload
    assert user_order.status == 1
  end


end
