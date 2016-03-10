# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160310140451) do

  create_table "orders", force: :cascade do |t|
    t.text     "description",   limit: 65535,               null: false
    t.float    "cost",          limit: 24,                  null: false
    t.float    "discount",      limit: 24,    default: 1.0
    t.string   "ip",            limit: 15,                  null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "promo_code_id", limit: 4
  end

  add_index "orders", ["promo_code_id"], name: "index_orders_on_promo_code_id", using: :btree

  create_table "promo_codes", force: :cascade do |t|
    t.string   "code",         limit: 255,              null: false
    t.float    "discount_sum", limit: 24,               null: false
    t.integer  "count",        limit: 4,   default: -1
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_foreign_key "orders", "promo_codes"
end
