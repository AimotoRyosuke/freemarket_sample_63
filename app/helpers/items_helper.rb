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
end
