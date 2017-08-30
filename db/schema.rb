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

ActiveRecord::Schema.define(version: 20170830195226) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachinary_files", force: :cascade do |t|
    t.string "attachinariable_type"
    t.bigint "attachinariable_id"
    t.string "scope"
    t.string "public_id"
    t.string "version"
    t.integer "width"
    t.integer "height"
    t.string "format"
    t.string "resource_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cars", force: :cascade do |t|
    t.string "immatriculation"
    t.string "brand"
    t.string "model"
    t.string "color"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.string "car_picture"
    t.index ["category_id"], name: "index_cars_on_category_id"
    t.index ["user_id"], name: "index_cars_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "price_cents", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cleanings", force: :cascade do |t|
    t.string "place"
    t.datetime "period"
    t.string "comment_access"
    t.boolean "requirements"
    t.integer "rating"
    t.string "status", default: "pending"
    t.string "images"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "car_id"
    t.float "latitude"
    t.float "longitude"
    t.index ["car_id"], name: "index_cleanings_on_car_id"
    t.index ["user_id"], name: "index_cleanings_on_user_id"
  end

  create_table "models", force: :cascade do |t|
    t.string "name"
    t.bigint "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_models_on_brand_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "state"
    t.integer "amount_cents", default: 0, null: false
    t.json "payment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "cleaning_id"
    t.index ["cleaning_id"], name: "index_orders_on_cleaning_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "firstname"
    t.string "lastname"
    t.string "address"
    t.string "phonenumber"
    t.boolean "cleaner", default: false
    t.float "latitude"
    t.float "longitude"
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cars", "categories"
  add_foreign_key "cars", "users"
  add_foreign_key "cleanings", "cars"
  add_foreign_key "cleanings", "users"
  add_foreign_key "models", "brands"
  add_foreign_key "orders", "cleanings"
end
