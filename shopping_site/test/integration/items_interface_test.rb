require 'test_helper'

class ItemsInterfaceTest < ActionDispatch::IntegrationTest
  def setup 
    item1 = items(:Test1)
    item2 = items(:Test2)
    item3 = items(:Test3)
    items = [item1, item2, item3]
  end
  test "should exist all items" do
    get root_path
    items.each do |item|
      assert_match item.name, response.body
      assert_match item.price.to_s, response.body
    end
  end

end
