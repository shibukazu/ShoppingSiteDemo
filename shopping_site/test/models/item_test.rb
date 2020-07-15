require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def setup
    @item = Admin.new(name: "test_item", price: 1234)
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
end
