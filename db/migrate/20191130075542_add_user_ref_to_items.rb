class AddUserRefToItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :condition,       :string
    remove_column :items, :shipping_cost,   :integer
    remove_column :items, :shipping_method, :integer
    remove_column :items, :days,            :integer
    remove_column :items, :status,          :integer

    add_reference :items, :condition,       null: false
    add_reference :items, :shipping_cost,   null: false
    add_reference :items, :shipping_method, null: false
    add_reference :items, :days,            null: false
    add_reference :items, :status,          null: false
    add_reference :items, :prefecture,      null: false
    add_reference :items, :user,            null: false, foreign_key: true
    # t.references    :brand,     null: false, foreign_key: true
  end
end
