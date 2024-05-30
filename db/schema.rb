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

ActiveRecord::Schema[7.1].define(version: 2024_05_30_114135) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "billings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "booking_id", null: false
    t.bigint "quotation_id", null: false
    t.decimal "total_amount", precision: 10, scale: 2
    t.string "type"
    t.decimal "ex_rate", precision: 10, scale: 2
    t.string "job_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "Draft"
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
    t.decimal "cost", precision: 10, scale: 2
    t.decimal "receivable", precision: 10, scale: 2
    t.decimal "profit", precision: 10, scale: 2
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
    t.string "email", null: false
    t.boolean "approved", default: false
    t.string "address"
    t.string "contact_number"
    t.index ["company_code"], name: "index_companies_on_company_code", unique: true
    t.index ["email"], name: "index_companies_on_email", unique: true
  end

  create_table "forwarders", force: :cascade do |t|
    t.string "name", null: false
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_forwarders_on_user_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "phone_number"
    t.string "email", null: false
    t.bigint "client_id"
    t.bigint "forwarder_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.bigint "user_id", null: false
    t.index ["client_id"], name: "index_people_on_client_id"
    t.index ["email"], name: "index_people_on_email", unique: true
    t.index ["forwarder_id"], name: "index_people_on_forwarder_id"
    t.index ["user_id"], name: "index_people_on_user_id"
  end

  create_table "quotations", force: :cascade do |t|
    t.string "incoterm"
    t.float "exchange_rate"
    t.string "origin"
    t.string "destination"
    t.decimal "total_price", precision: 10, scale: 2
    t.bigint "user_id", null: false
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "draft"
    t.string "reference"
    t.index ["client_id"], name: "index_quotations_on_client_id"
    t.index ["reference"], name: "index_quotations_on_reference", unique: true
    t.index ["user_id"], name: "index_quotations_on_user_id"
  end

  create_table "quote_line_items", force: :cascade do |t|
    t.string "description"
    t.string "currency", limit: 3
    t.decimal "cost", precision: 10, scale: 2
    t.string "frequency"
    t.float "quantity"
    t.decimal "total", precision: 10, scale: 2
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
    t.index ["email", "company_id"], name: "index_users_on_email_and_company_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "billings", "bookings"
  add_foreign_key "billings", "quotations"
  add_foreign_key "billings", "users"
  add_foreign_key "bookings", "forwarders"
  add_foreign_key "bookings", "quotations"
  add_foreign_key "bookings", "users"
  add_foreign_key "clients", "users"
  add_foreign_key "forwarders", "users"
  add_foreign_key "people", "clients"
  add_foreign_key "people", "forwarders"
  add_foreign_key "people", "users"
  add_foreign_key "quotations", "clients"
  add_foreign_key "quotations", "users"
  add_foreign_key "quote_line_items", "quotations"
  add_foreign_key "users", "companies"
end
