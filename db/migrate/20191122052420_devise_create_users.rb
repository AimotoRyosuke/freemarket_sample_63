# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string     :nickname, null: false
      t.string     :email, null: false, default: ""
      t.string     :encrypted_password, null: false
      t.string     :reset_password_token
      t.datetime   :reset_password_sent_at
      t.datetime   :remember_created_at
      t.date       :birth, null: false
      t.text       :image, null: false
      t.integer    :assetes, default: 0
      t.integer    :point, default: 500
      t.string     :first_name, null: false
      t.string     :last_name, null: false
      t.string     :first_name_kana, null: false
      t.string     :last_name_kana, null: false
      t.integer    :tel, null: false, unique: true
      t.text       :profile
      t.timestamps null: false
    end
    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :tel,                  unique: true
  end
end