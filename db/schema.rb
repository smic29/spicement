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

ActiveRecord::Schema[7.1].define(version: 2024_05_12_155139) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "billings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "booking_id", null: false
    t.bigint "quotation_id", null: false
    t.float "total_amount"
    t.string "type"
    t.float "ex_rate"
    t.string "job_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_billings_on_booking_id"
    t.index ["quotation_id"], name: "index_billings_on_quotation_id"
    t.index ["user_id"], name: "index_billings_on_user_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "quotation_id", null: false
    t.bigint "user_id", null: false
    t.bigint "forwarder_id", null: false
    t.string "services"
    t.string "bl_number"
    t.integer "cost"
    t.integer "receivable"
    t.integer "profit"
    t.string "status", default: "Ongoing"
    t.date "eta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["forwarder_id"], name: "index_bookings_on_forwarder_id"
    t.index ["quotation_id"], name: "index_bookings_on_quotation_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.string "company_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_code"], name: "index_companies_on_company_code", unique: true
  end

  create_table "forwarders", force: :cascade do |t|
    t.string "name", null: false
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "users_id", null: false
    t.index ["users_id"], name: "index_forwarders_on_users_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.string "email", null: false
    t.bigint "client_id"
    t.bigint "forwarder_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_people_on_client_id"
    t.index ["email"], name: "index_people_on_email", unique: true
    t.index ["forwarder_id"], name: "index_people_on_forwarder_id"
  end

  create_table "quotations", force: :cascade do |t|
    t.string "incoterm"
    t.float "exchange_rate"
    t.string "origin"
    t.string "destination"
    t.float "total_price"
    t.bigint "user_id", null: false
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "draft"
    t.index ["client_id"], name: "index_quotations_on_client_id"
    t.index ["user_id"], name: "index_quotations_on_user_id"
  end

  create_table "quote_line_items", force: :cascade do |t|
    t.string "description"
    t.string "currency", limit: 3
    t.integer "cost"
    t.string "frequency"
    t.integer "quantity"
    t.integer "total"
    t.bigint "quotation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quotation_id"], name: "index_quote_line_items_on_quotation_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "admin", default: false
    t.bigint "company_id", null: false
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "billings", "bookings"
  add_foreign_key "billings", "quotations"
  add_foreign_key "billings", "users"
  add_foreign_key "bookings", "forwarders"
  add_foreign_key "bookings", "quotations"
  add_foreign_key "bookings", "users"
  add_foreign_key "clients", "users"
  add_foreign_key "forwarders", "users", column: "users_id"
  add_foreign_key "people", "clients"
  add_foreign_key "people", "forwarders"
  add_foreign_key "quotations", "clients"
  add_foreign_key "quotations", "users"
  add_foreign_key "quote_line_items", "quotations"
  add_foreign_key "users", "companies"
end
