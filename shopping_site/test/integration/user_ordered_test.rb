require 'test_helper'

class UserOrderedTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test1)
    @item = items(:Test1)
    orders.each do |order|
      order.items << @item
      @user.orders << order
    end
    @admin = Admin.new(email: "master@test.com", password: "1234567890")
  end

  test "user ordered" do
    #注文一覧へのリンクのテスト
    log_in_as_user(@user)
    get root_path
    assert_select "a[href=?]", user_path(@user), text: "注文履歴一覧" 
    #注文一覧へのテスト
    get user_path(@user)
    @user.orders.each do |order|
      assert_select "td", text: order.items.first.name.to_s + "などのご注文"
      assert_select "td", text: order.created_at.to_s 
    end
    #注文詳細へのテスト
    #入金待ち状態
    user_order = @user.orders.first
    get order_path(user_order)
    assert_match "入金待ち", response.body
    sum = 0
    user_order.items.each do |item|
      assert_select "td", text: item.name.to_s
      assert_select "td", text: item.price.to_s
      sum += item.price
    end
    assert_match sum.to_s, response.body
    #発送待ち
    log_in_as_admin(@admin)
    patch orders_admin_update_path(order_id: user_order.id), params: {status: 1}
    get order_path(user_order)
    assert_match "発送待ち", response.body
    #発送済み
    patch orders_admin_update_path(order_id: user_order.id), params: {status: 2}
    get order_path(user_order)
    assert_match "発送完了", response.body




    
    

  end
end
