require 'test_helper'

class CartTest < ActiveSupport::TestCase
  def setup
    user = users(:test1)
    item = items(:Test1)
    @cart = Cart.new(user_id: user.id, item_id: item.id)
  end


  test "should be valid" do
    assert @cart.valid?
  end

  test "user_id should be present" do
    @cart.user_id = ""
    assert_not @cart.valid?
  end

  test "item_id should be present" do
    @cart.item_id = ""
    assert_not @cart.valid?
  end
end
