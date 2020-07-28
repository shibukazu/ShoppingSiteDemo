require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @item = items(:Test1)
    @admin = Admin.new(email: "master@test.com", password: "1234567890")
    @new_item = Item.new(name: "TestPhone2", price: 12000)
  end

  test "should be able to see item's table with valid login" do
    log_in_as_admin(@admin)
    get items_path
    assert_template 'items/index'
  end

  test "should not be able to see item's table without valid login" do
    get items_path
    assert_redirected_to root_path
  end

  test "should not be able to create new item without valid login" do
    assert_no_difference 'Item.count' do
      post items_path, params: { item: { name: @new_item.name, price: @new_item.price} }
    end
    assert_redirected_to root_path
  end

  test "should  be able to create new item with valid login" do
    log_in_as_admin(@admin)
    assert_difference 'Item.count', 1 do
      post items_path, params: { item: { name: @new_item.name, price: @new_item.price} }
    end
    assert_redirected_to items_path
  end


  test "should not be able to edit item without valid login" do
    patch item_path(@item), params: { item: { name: "Edit", price: 15000 } }
    @item.reload
    assert_not @item.name == 'Edit'
    assert_redirected_to root_path
  end

  test "should not be able to delete item without valid login" do
    assert_no_difference 'Item.count' do
      delete item_path(@item)
    end
    assert_redirected_to root_path
  end
end
