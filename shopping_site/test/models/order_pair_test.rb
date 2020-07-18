require 'test_helper'

class OrderPairTest < ActiveSupport::TestCase
  def setup
    @user = users(:test1)
    @order = orders(:test1)
    @item = items(:Test1)
    @order_pair = OrderPair.new(order_id: @order.id, item_id: @item.id)
  end


  test "should be valid" do
    assert @order_pair.valid?
  end

  test "order_id should be present" do
    @order_pair.order_id = ""
    assert_not @order_pair.valid?
  end

  test "item_id should be present" do
    @order_pair.item_id = ""
    assert_not @order_pair.valid?
  end

  test "should get order info" do
    assert @order_pair.order == @order
  end

  test "should get item info" do
    assert @order_pair.item == @item
  end

  test "should be able to save the same order pair" do
    other_order_pair = OrderPair.new(order_id: @order.id, item_id: @item.id)
    @order_pair.save
    assert other_order_pair.valid?
    assert other_order_pair.save
  end
  
end
