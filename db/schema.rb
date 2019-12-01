# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_30_143739) do

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "first_name_kana", null: false
    t.string "last_name_kana", null: false
    t.integer "zip_code", null: false
    t.bigint "prefecture_id", null: false
    t.string "city", null: false
    t.string "address", null: false
    t.string "building"
    t.string "tel", limit: 16
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prefecture_id"], name: "index_addresses_on_prefecture_id"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "credits", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "number", limit: 16, null: false
    t.integer "security", null: false
    t.date "year", null: false
    t.date "month", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_credits_on_user_id"
  end

  create_table "images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "image", null: false
    t.bigint "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_images_on_item_id"
  end

  create_table "items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "size"
    t.integer "price", null: false
    t.text "explanation", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "condition_id", null: false
    t.bigint "shipping_cost_id", null: false
    t.bigint "shipping_method_id", null: false
    t.bigint "days_id", null: false
    t.bigint "status_id", null: false
    t.bigint "prefecture_id", null: false
    t.bigint "user_id", null: false
    t.index ["condition_id"], name: "index_items_on_condition_id"
    t.index ["days_id"], name: "index_items_on_days_id"
    t.index ["prefecture_id"], name: "index_items_on_prefecture_id"
    t.index ["shipping_cost_id"], name: "index_items_on_shipping_cost_id"
    t.index ["shipping_method_id"], name: "index_items_on_shipping_method_id"
    t.index ["status_id"], name: "index_items_on_status_id"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "sns_auths", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "provider", null: false
    t.string "uid", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sns_auths_on_user_id"
  end

  create_table "sns_credentials", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sns_credentials_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nickname", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.date "birth", null: false
    t.text "image"
    t.integer "assetes", default: 0
    t.integer "point", default: 500
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "first_name_kana", null: false
    t.string "last_name_kana", null: false
    t.string "tel", limit: 16, null: false
    t.text "profile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["tel"], name: "index_users_on_tel", unique: true
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "credits", "users"
  add_foreign_key "images", "items"
  add_foreign_key "items", "users"
  add_foreign_key "sns_credentials", "users"
end
