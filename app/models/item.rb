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
end
