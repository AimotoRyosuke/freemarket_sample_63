class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :days
  belongs_to_active_hash :shipping_cost
  belongs_to_active_hash :shipping_method
  belongs_to_active_hash :condition
  belongs_to :user
  has_many   :images, dependent: :destroy

  # belongs_to :brand
  # belongs_to :categories_hierarchie
  # has_many   :likes
  # has_many   :comments
  # has_many   :todos, dependent: :destroy
  # has_many   :notices, dependent: :destroy
  # has_many   :messages
end
