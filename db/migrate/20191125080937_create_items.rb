class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string      :name,                    null: false
      t.string      :size
      t.integer     :price,                   null: false
      t.string      :condition,               null: false
      t.text        :explanation,             null: false
      t.integer     :shipping_cost,           null: false
      t.integer     :shipping_method,         null: false
      t.integer     :days,                    null: false
      t.integer     :status,                  null: false
      # t.references  :user,                  null: false, foreign_key: true
      # t.references  :categories_hierarchie, null: false, foreign_key: true
      # t.references  :brand,                 null: false, foreign_key: true
      t.timestamps
    end
  end
end
