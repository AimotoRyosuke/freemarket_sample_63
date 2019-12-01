class AddDefaultStatusToItem < ActiveRecord::Migration[5.2]
  def change
    remove_reference :items, :status
    
    add_reference :items, :status, null: false, :default => 1
  end
end
