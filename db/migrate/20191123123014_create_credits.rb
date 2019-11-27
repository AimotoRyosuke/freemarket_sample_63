class CreateCredits < ActiveRecord::Migration[5.2]
  def change
    create_table :credits do |t|
      t.string     :number, null: false, limit: 16
      t.integer    :security, null: false
      t.date       :year, null:false
      t.date       :month, null:false
      t.references :user, null:false, foreign_key: true
      t.timestamps
    end
  end
end
