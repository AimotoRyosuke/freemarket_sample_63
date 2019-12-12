class Category < ApplicationRecord
  has_closure_tree
  has_many :items
end
