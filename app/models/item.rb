class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :name, :price, :explanation, :condition_id, :shipping_cost_id, :days_id, :prefecture_id, :shipping_method_id, :status_id, :category_id, :images, presence: true
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :days
  belongs_to_active_hash :shipping_cost
  belongs_to_active_hash :shipping_method
  belongs_to_active_hash :condition
  belongs_to_active_hash :status
  has_many               :images, dependent: :destroy
  has_one                :purchase
  has_one                :category
  belongs_to             :user
  accepts_nested_attributes_for :images


  # belongs_to :brand
  # belongs_to :categories_hierarchie
  # has_many   :likes
  # has_many   :comments
  # has_many   :todos, dependent: :destroy
  # has_many   :notices, dependent: :destroy
  # has_many   :messages


  def self.search(keyword, condition, shipping_cost, status, minprice, maxprice, largecategory, middlecategory, category) 
    scope :word, -> { where('((name LIKE(?)) OR (explanation LIKE(?)))', "%#{keyword}%", "%#{keyword}%") if keyword.present?}
    scope :condi, -> { where('(condition_id IN(?))',condition) unless condition == ['']}
    scope :cost, -> { where('(shipping_cost_id IN(?))',shipping_cost) unless shipping_cost == ['']}
    scope :state, -> { where('(status_id IN(?))',status) unless status == ['']}
    scope :minpr, -> { where("price >= ?", minprice) if minprice.present?}
    scope :maxpr, -> { where("price <= ?", maxprice) if maxprice.present?}
    scope :large, -> { where("(category_id IN(?))", Category.leaves.with_ancestor(largecategory).ids) if largecategory.present?}
    scope :middle, -> { where("(category_id IN(?))", Category.leaves.with_ancestor(middlecategory).ids) if middlecategory.present?}
    scope :cate, -> { where('(category_id IN(?))',category) if category.present?}
    scope :detailsearch, -> { word.condi.cost.state.minpr.maxpr.large.middle.cate }
    return Item.detailsearch
  end

  def large_category_list
    return Category.roots
  end

  def mid_category_list(large_category)
    return Category.find_all_by_generation(1).with_ancestor(large_category.id).to_a
  end

  def small_category_list(mid_category)
    category = Category.leaves.with_ancestor(mid_category.id).to_a
  end

end