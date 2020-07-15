require 'test_helper'

class AdminItemsPageTest < ActionDispatch::IntegrationTest
  def setup
    @admin = Admin.new(email: "master@test.com", password: "1234567890")
    @item = items(:Test1)
    @new_item = Item.new(name: "NewItem", price: 12000)
  end

  test "when access to index should redirect root without login" do
    get items_path
    assert_redirected_to root_url
  end

  test "when access to item registration should redirect root without login" do
    get new_item_path
    assert_redirected_to root_url
  end

  test "when access to edit item should redirect root without login" do
    get edit_item_path(@item)
    assert_redirected_to root_url
  end

  test "When update item without login should redirect root" do
    patch item_path(@item), params: { item: { name: "TestTest",
                                            price: 1234 } }
    assert_redirected_to root_url
  end

  test "When create item without login should redirect root" do
    assert_no_difference 'Item.count' do
      post items_path, params: { item: { name: "TestTest",
                                        price: 1234 } }
    end
    assert_redirected_to root_url
  end

  test "When destroy item without login should redirect root" do
    assert_no_difference 'Item.count' do
      delete item_path(@item)
    end
    assert_redirected_to root_url
  end

  test "valid access to index " do
    log_in_as_admin(@admin)
    get items_path
    assert_template 'items/index'
  end

  test "valid access to item registration" do
    log_in_as_admin(@admin)
    get new_item_path
    assert_template 'items/new'
  end

  test "valid access to item edit" do
    log_in_as_admin(@admin)
    get edit_item_path(@item)
    assert_template 'items/edit'
  end

  test "should be chenged when updated with login" do
    log_in_as_admin(@admin)
    patch item_path(@item), params: { item: { name: "TestTest",
                                            price: 1234 } }
    
    tmp = @item.dup
    @item.reload
    assert @item != tmp
    assert_redirected_to items_path
  end

  test "should increase item when register item with login" do
    log_in_as_admin(@admin)
    assert_difference 'Item.count', 1 do
      post items_path, params: { item: { name: "TestTest",
                                        price: 1234 } }
    end
    assert_redirected_to items_path
  end

  test "should decrease item when destroy item with login" do
   log_in_as_admin(@admin)
   assert_difference 'Item.count', -1 do
    delete item_path(@item)
   end
   assert_redirected_to items_path
  end


  

end
