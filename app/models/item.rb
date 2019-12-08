class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :days
  belongs_to_active_hash :shipping_cost
  belongs_to_active_hash :shipping_method
  belongs_to_active_hash :condition
  belongs_to_active_hash :status
  has_many               :images, dependent: :destroy
  has_one                :purchase
  belongs_to             :user
  accepts_nested_attributes_for :images

  # belongs_to :brand
  # belongs_to :categories_hierarchie
  # has_many   :likes
  # has_many   :comments
  # has_many   :todos, dependent: :destroy
  # has_many   :notices, dependent: :destroy
  # has_many   :messages


  def self.search(keyword, condition, shipping_cost, status, minprice, maxprice)
    scope :word, -> { where('((name LIKE(?)) OR (explanation LIKE(?)))', "%#{keyword}%", "%#{keyword}%") if keyword.present?}
    scope :condi, -> { where('(condition_id IN(?))',condition) unless condition == ['']}
    scope :cost, -> { where('(shipping_cost_id IN(?))',shipping_cost) unless shipping_cost == ['']}
    scope :state, -> { where('(status_id IN(?))',status) unless status == ['']}
    scope :minpr, -> { where("price >= ?", minprice) if minprice.present?}
    scope :maxpr, -> { where("price <= ?", maxprice) if maxprice.present?}
    scope :detailsearch, -> { word.condi.cost.state.minpr.maxpr }
    Item.detailsearch
  end

end
