class CategoriesHierarchy < ApplicationRecord
  # belongs_to :ancestor_id, class_name: 'Category'
  # belongs_to :descendant_id, class_name: 'Category'
  has_many :items
end
