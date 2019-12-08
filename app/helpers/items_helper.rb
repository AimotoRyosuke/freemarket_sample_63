module ItemsHelper
  def price_shipping_cost(item)
    if item.shipping_cost.name == '送料込み(出品者負担)'
      item.shipping_cost.name.slice(0..3)
    else
      item.shipping_cost.name.slice(0..2)
    end
  end

  def trade_count(item)
    sell_count = Item.where(user_id: @item.user.id,status_id: 2).count
    purchase_count = Purchase.where(user_id: @item.user.id).count
    trade_count = sell_count + purchase_count
  end
    
  def large_category_list
    large_category = Category.roots
  end

  def mid_category_list(large_category)
    return Category.find_all_by_generation(1).with_ancestor(large_category.id).to_a
  end

  def small_category_list(mid_category)
    category = Category.leaves.with_ancestor(mid_category.id)
  end

  def itemc_ategory_id(large_category, mid_category, small_category)
    return
  end
end
