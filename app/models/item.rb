class Item < ApplicationRecord


  # belongs_to :user class_name: 'User' :foreign key seller_id
  # belongs_to :address, dependent: :destroy
  # belongs_to :brand
  # belongs_to :categories_hierarchie
  # has_many   :likes
  # has_many   :comments
  has_many   :images, dependent: :destroy
  # has_many   :todos, dependent: :destroy
  # has_many   :notices, dependent: :destroy
  # has_many   :messages

  def item_status(item)
    if item.status == 1
      "新品、未使用"
    elsif item.status == 2
      "未使用に近い"
    elsif item.status == 3
      "目立った傷や汚れなし"
    elsif item.status == 4
      "やや傷や汚れあり"
    elsif item.status == 5
      "傷や汚れあり"
    else item.status == 6
      "全体的に状態が悪い"
    end
  end

  def detail_shipping_cost(item)
    if item.shipping_cost == 1
      "送料込み(出品者負担)"
    else
      "着払い(購入者負担)"
    end
  end

  def price_box_shippingcost(item)
    if item.shipping_cost == 1
      "送料込み"
    else
      "着払い"
    end
  end
  
  def item_shipping_method(item)
    if item.shipping_method == 1
      "らくらくメルカリ便"
    elsif item.shipping_method == 2
      "ゆうゆうメルカリ便"
    elsif item.shipping_method == 3
      "大型らくらくメルカリ便"
    elsif item.shipping_method == 4
      "未定"
    elsif item.shipping_method == 5
      "ゆうメール"
    elsif item.shipping_method == 6
      "レターパック"
    elsif item.shipping_method == 7
      "普通郵便(定形、定形外)"
    elsif item.shipping_method == 8
      "クロネコヤマト"
    elsif item.shipping_method == 9
      "ゆうパック"
    elsif item.shipping_method == 10
      "クリックポスト"
    elsif item.shipping_method == 11
      "ゆうパケット"
    end
  end

  def item_days(item)
    if item.days == 1
      "1~2日で発送"
    elsif item.days == 2
      "2~3日で発送"
    else item.days == 3
      "4~7日で発送"
    end 
  end
end
