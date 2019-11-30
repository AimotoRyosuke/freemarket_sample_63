module ItemsHelper
  def price_shipping_cost(item)
    if item.shipping_cost.name == '送料込み(出品者負担)'
      item.shipping_cost.name.slice(0..3)
    else
      item.shipping_cost.name.slice(0..2)
    end
  end
end
