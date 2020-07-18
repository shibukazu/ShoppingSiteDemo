require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
    @user = users(:test1)
    @item = items(:Test1)
    @order_pair = OrderPair.new(item_id: @item.id)
    @order = Order.new(user_id: @user.id, status: 0)
    
  end


  test "should be valid" do
    @order.order_pairs << @order_pair
    assert @order.valid?
  end


  test "don't have to have order_pair" do
    assert @order.order_pairs.empty?
    assert @order.valid?
  end

  test "user_id should be present" do
    @order.user_id = ""
    assert_not @order.valid?
  end

  test "status should be present" do
    @order.status = ""
    assert_not @order.valid?
  end

  test "should get user info" do
    assert @order.user == @user
  end

  test "should get order items" do
    @order.order_pairs << @order_pair
    @order_pair.save
    assert @item == @order.items.first
  end

  
  
end
