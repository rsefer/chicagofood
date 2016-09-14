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

ActiveRecord::Schema.define(version: 20160914142911) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "body"
    t.integer  "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "private",    default: false
  end

  add_index "comments", ["venue_id"], name: "index_comments_on_venue_id", using: :btree

  create_table "eats", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_rating_id"
  end

  add_index "eats", ["item_id"], name: "index_eats_on_item_id", using: :btree
  add_index "eats", ["item_rating_id"], name: "index_eats_on_item_rating_id", using: :btree
  add_index "eats", ["user_id"], name: "index_eats_on_user_id", using: :btree

  create_table "item_ratings", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "user_id"
    t.boolean  "liked",      default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_ratings", ["item_id"], name: "index_item_ratings_on_item_id", using: :btree
  add_index "item_ratings", ["user_id"], name: "index_item_ratings_on_user_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.integer  "venue_id"
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["venue_id"], name: "index_items_on_venue_id", using: :btree

  create_table "list_items", force: :cascade do |t|
    t.integer  "list_id"
    t.date     "date"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "venue_id"
    t.boolean  "manual_entry",    default: false
    t.string   "venue_name"
    t.integer  "neighborhood_id"
    t.integer  "venuetype_id"
  end

  add_index "list_items", ["list_id"], name: "index_list_items_on_list_id", using: :btree
  add_index "list_items", ["neighborhood_id"], name: "index_list_items_on_neighborhood_id", using: :btree
  add_index "list_items", ["venue_id"], name: "index_list_items_on_venue_id", using: :btree
  add_index "list_items", ["venuetype_id"], name: "index_list_items_on_venuetype_id", using: :btree

  create_table "lists", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "private"
    t.string   "title",       limit: 255
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "showmap",                 default: true
  end

  add_index "lists", ["user_id"], name: "index_lists_on_user_id", using: :btree

  create_table "neighborhoods", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.integer  "parent_neighborhood_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "rating"
    t.integer  "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["venue_id"], name: "index_ratings_on_venue_id", using: :btree

  create_table "to_tries", force: :cascade do |t|
    t.integer  "venue_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "to_tries", ["user_id"], name: "index_to_tries_on_user_id", using: :btree
  add_index "to_tries", ["venue_id"], name: "index_to_tries_on_venue_id", using: :btree

  create_table "tries", force: :cascade do |t|
    t.integer  "venue_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tries", ["user_id"], name: "index_tries_on_user_id", using: :btree
  add_index "tries", ["venue_id"], name: "index_tries_on_venue_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                              default: false
    t.string   "avatar",                 limit: 255
    t.string   "firstname",              limit: 255
    t.string   "lastname",               limit: 255
    t.string   "street",                 limit: 255
    t.string   "city",                   limit: 255
    t.string   "state",                  limit: 255
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venues", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.integer  "venuetype_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "street",          limit: 255
    t.string   "city",            limit: 255
    t.string   "state",           limit: 255
    t.integer  "neighborhood_id"
    t.boolean  "byob"
    t.integer  "price"
    t.boolean  "craftbeer"
    t.boolean  "cocktails"
    t.boolean  "latenight"
    t.boolean  "cashonly"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "outdoor"
  end

  create_table "venuetypes", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "parent_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "list_items", "neighborhoods"
  add_foreign_key "list_items", "venuetypes"
end
