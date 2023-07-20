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

ActiveRecord::Schema[7.0].define(version: 2023_07_20_091100) do
  create_table "banks", force: :cascade do |t|
    t.string "name"
    t.string "bic_number"
    t.string "iban_number"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_banks_on_user_id"
  end

  create_table "bills", force: :cascade do |t|
    t.integer "number"
    t.decimal "total_amount"
    t.boolean "payed"
    t.integer "year"
    t.string "month"
    t.date "emission_date"
    t.date "due_date"
    t.integer "client_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "taxes", default: false
    t.index ["client_id"], name: "index_bills_on_client_id"
    t.index ["user_id"], name: "index_bills_on_user_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "post_code"
    t.string "city"
    t.integer "siret_number"
    t.string "tva_number"
    t.string "phone_number"
    t.string "email"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "unity"
    t.decimal "quantity"
    t.decimal "unit_price"
    t.integer "bill_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bill_id"], name: "index_items_on_bill_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "address"
    t.string "post_code"
    t.string "city"
    t.integer "siret_number"
    t.string "tva_number"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "banks", "users"
  add_foreign_key "bills", "clients"
  add_foreign_key "bills", "users"
  add_foreign_key "clients", "users"
  add_foreign_key "items", "bills"
end
