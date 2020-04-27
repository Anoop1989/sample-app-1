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

ActiveRecord::Schema.define(version: 20200427094347) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: :cascade do |t|
    t.integer  "payer_id",                     null: false
    t.date     "bill_date"
    t.float    "bill_amount",    default: 0.0
    t.string   "bill_status"
    t.float    "payment_amount", default: 0.0
    t.date     "payment_date"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "external_service_providers", force: :cascade do |t|
    t.string   "name",         null: false
    t.string   "auth_id"
    t.string   "auth_secret"
    t.string   "status"
    t.datetime "activated_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "payers", force: :cascade do |t|
    t.string   "full_name",     null: false
    t.text     "address"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "mobile_number"
  end

  create_table "receipts", force: :cascade do |t|
    t.float    "amount_paid"
    t.string   "amount_paid_currency_code"
    t.integer  "bill_id"
    t.string   "platform_bill_id"
    t.integer  "external_service_provider_id"
    t.string   "service_provider_transaction_id"
    t.jsonb    "additional_info"
    t.string   "unique_payment_ref_id"
    t.datetime "generated_at"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

end
