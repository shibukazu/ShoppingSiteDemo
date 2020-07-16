require 'test_helper'

class ItemsInterfaceTest < ActionDispatch::IntegrationTest
  def setup 
    @item1 = items(:Test1)
    item2 = items(:Test2)
    item3 = items(:Test3)
    items = [@item1, item2, item3]
    @user = users(:test1)
  end
  test "should exist all items" do
    get root_path
    items.each do |item|
      assert_match item.name, response.body
      assert_match item.price.to_s, response.body
    end
  end

  test "cart function" do
    get root_path
    log_in_as_user(@user)
    follow_redirect!
    assert_match carts_path.to_s, response.body
    assert_match "カートに追加", response.body
    post carts_path, params: { item_id: @item1.id }
    get carts_path
    carts = assigns(:carts)
    carts.each do |cart|
      assert_match cart.item.name, response.body
      assert_match cart.item.price.to_s, response.body
      assert_match cart_path(cart).to_s, response.body
    end
  end
end