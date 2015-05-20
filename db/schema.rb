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

ActiveRecord::Schema.define(version: 20150518163129) do

  create_table "accesses", force: :cascade do |t|
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "accesses", ["user_id"], name: "index_accesses_on_user_id"

  create_table "primers", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.string   "sequence"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "primers", ["code"], name: "index_primers_on_code", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_hash"
    t.integer  "access_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "users", ["access_id"], name: "index_users_on_access_id"

end
