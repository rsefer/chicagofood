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

ActiveRecord::Schema.define(version: 20140930193931) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.text     "body"
    t.integer  "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "private",    default: false
  end

  add_index "comments", ["venue_id"], name: "index_comments_on_venue_id", using: :btree

  create_table "eats", force: true do |t|
    t.integer  "item_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "eats", ["item_id"], name: "index_eats_on_item_id", using: :btree
  add_index "eats", ["user_id"], name: "index_eats_on_user_id", using: :btree

  create_table "item_ratings", force: true do |t|
    t.integer  "item_id"
    t.integer  "user_id"
    t.boolean  "liked",      default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_ratings", ["item_id"], name: "index_item_ratings_on_item_id", using: :btree
  add_index "item_ratings", ["user_id"], name: "index_item_ratings_on_user_id", using: :btree

  create_table "items", force: true do |t|
    t.integer  "venue_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["venue_id"], name: "index_items_on_venue_id", using: :btree

  create_table "neighborhoods", force: true do |t|
    t.string   "name"
    t.integer  "parent_neighborhood_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", force: true do |t|
    t.integer  "user_id"
    t.integer  "rating"
    t.integer  "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["venue_id"], name: "index_ratings_on_venue_id", using: :btree

  create_table "to_tries", force: true do |t|
    t.integer  "venue_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "to_tries", ["user_id"], name: "index_to_tries_on_user_id", using: :btree
  add_index "to_tries", ["venue_id"], name: "index_to_tries_on_venue_id", using: :btree

  create_table "tries", force: true do |t|
    t.integer  "venue_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tries", ["user_id"], name: "index_tries_on_user_id", using: :btree
  add_index "tries", ["venue_id"], name: "index_tries_on_venue_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.string   "avatar"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venues", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "venuetype_id"
    t.string   "yelpid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.integer  "neighborhood_id"
    t.boolean  "byob"
    t.integer  "price"
    t.boolean  "craftbeer"
    t.boolean  "cocktails"
    t.boolean  "latenight"
    t.boolean  "cashonly"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "venuetypes", force: true do |t|
    t.string   "name"
    t.integer  "parent_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
