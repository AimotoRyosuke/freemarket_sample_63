module ItemsHelper
  def item_status(item)
    case item.status
    when 1
      "新品、未使用"
    when 2
      "未使用に近い"
    when 3
      "目立った傷や汚れなし"
    when 4
      "やや傷や汚れあり"
    when 5
      "傷や汚れあり"
    else
      "全体的に状態が悪い"
    end
  end

  def detail_shipping_cost(item)
    case item.shipping_cost
    when 1
      "送料込み(出品者負担)"
    else
      "着払い(購入者負担)"
    end
  end

  def price_box_shippingcost(item)
    case item.shipping_cost
    when 1
      "送料込み"
    else
      "着払い"
    end
  end
  
  def item_shipping_method(item)
    case item.shipping_method
    when 1
      "らくらくメルカリ便"
    when 2
      "ゆうゆうメルカリ便"
    when 3
      "大型らくらくメルカリ便"
    when 4
      "未定"
    when 5
      "ゆうメール"
    when 6
      "レターパック"
    when 7
      "普通郵便(定形、定形外)"
    when 8
      "クロネコヤマト"
    when 9
      "ゆうパック"
    when 10
      "クリックポスト"
    when 11
      "ゆうパケット"
    end
  end

  def item_days(item)
    case item.days
    when 1
      "1~2日で発送"
    when 2
      "2~3日で発送"
    else
      "4~7日で発送"
    end 
  end
end
