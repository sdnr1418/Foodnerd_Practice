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

ActiveRecord::Schema[8.1].define(version: 2026_07_08_131252) do
  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "phone"
    t.string "profile_picture_url"
    t.datetime "updated_at", null: false
  end

  create_table "inventory_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "minimum_required_stock"
    t.string "name"
    t.boolean "requires_restock"
    t.integer "restaurant_id", null: false
    t.integer "stock_level"
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_inventory_items_on_restaurant_id"
  end

  create_table "menu_items", force: :cascade do |t|
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.decimal "price", precision: 10, scale: 2
    t.integer "restaurant_id", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_menu_items_on_category_id"
    t.index ["restaurant_id"], name: "index_menu_items_on_restaurant_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "menu_item_id", null: false
    t.integer "order_id", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_item_id"], name: "index_order_items_on_menu_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "customer_name"
    t.string "order_type"
    t.decimal "total_price"
    t.datetime "updated_at", null: false
  end

  create_table "restaurants", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "location"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "inventory_items", "restaurants"
  add_foreign_key "menu_items", "categories"
  add_foreign_key "menu_items", "restaurants"
  add_foreign_key "order_items", "menu_items"
  add_foreign_key "order_items", "orders"
end
