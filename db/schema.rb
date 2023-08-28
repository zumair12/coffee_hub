# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_13_142601) do
  create_table "discounts", force: :cascade do |t|
    t.integer "item_id", null: false
    t.integer "applicable_item_id"
    t.decimal "discount_rate", precision: 4, scale: 2
    t.decimal "cap_amount", precision: 14, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicable_item_id"], name: "index_discounts_on_applicable_item_id"
    t.index ["item_id"], name: "index_discounts_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 14, scale: 2
    t.decimal "tax_rate", precision: 14, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "item_id", null: false
    t.integer "quantity"
    t.decimal "price", precision: 14, scale: 2
    t.decimal "discount", precision: 14, scale: 2
    t.decimal "taxable_amount", precision: 14, scale: 2
    t.decimal "payable", precision: 14, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "customer_name"
    t.string "customer_contact"
    t.string "order_type"
    t.string "state"
    t.decimal "price", precision: 14, scale: 2
    t.decimal "discount", precision: 14, scale: 2
    t.decimal "taxable_amount", precision: 14, scale: 2
    t.decimal "payable", precision: 14, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "discounts", "items"
  add_foreign_key "discounts", "items", column: "applicable_item_id"
  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
end
