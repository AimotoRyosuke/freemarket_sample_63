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

  def self.search(search)
      Item.where('((name LIKE(?)) OR (explanation LIKE(?))) AND (status_id IN(?))', "%#{search}%", "%#{search}%", 1..3)
  end

  def large_category_list
    return Category.roots
  end

  def mid_category_list(large_category)
    return Category.find_all_by_generation(1).with_ancestor(large_category.id).to_a
  end

  def small_category_list(mid_category)
    category = Category.leaves.with_ancestor(mid_category.id)
  end

end
