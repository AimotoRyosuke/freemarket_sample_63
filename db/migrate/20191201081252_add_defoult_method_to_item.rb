class AddDefoultMethodToItem < ActiveRecord::Migration[5.2]
  def change
    remove_reference :items, :shipping_method
    
    add_reference :items, :shipping_method, null: false, :default => 4
  end
end
