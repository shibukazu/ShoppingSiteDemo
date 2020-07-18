require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def setup
    @item = Item.new(name: "test", price: 1234)
  end


  test "should be valid" do
    assert @item.valid?
  end

  test "email should be present" do
    @item.name = ""
    assert_not @item.valid?
  end

  test "password should be present" do
    @item.price = ""
    assert_not @item.valid?
  end

  test "don't have to have other_pairs" do
    assert @item.order_pairs.empty?
    assert @item.valid?
  end

  test "don't have to have carts" do
    assert @item.carts.empty?
    assert @item.valid?
  end
end
