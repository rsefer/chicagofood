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

ActiveRecord::Schema.define(version: 20180418035830) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.text "body"
    t.integer "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "private", default: false
    t.index ["venue_id"], name: "index_comments_on_venue_id"
  end

  create_table "eats", id: :serial, force: :cascade do |t|
    t.integer "item_id"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "item_rating_id"
    t.index ["item_id"], name: "index_eats_on_item_id"
    t.index ["item_rating_id"], name: "index_eats_on_item_rating_id"
    t.index ["user_id"], name: "index_eats_on_user_id"
  end

  create_table "item_ratings", id: :serial, force: :cascade do |t|
    t.integer "item_id"
    t.integer "user_id"
    t.boolean "liked", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["item_id"], name: "index_item_ratings_on_item_id"
    t.index ["user_id"], name: "index_item_ratings_on_user_id"
  end

  create_table "items", id: :serial, force: :cascade do |t|
    t.integer "venue_id"
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["venue_id"], name: "index_items_on_venue_id"
  end

  create_table "list_items", id: :serial, force: :cascade do |t|
    t.integer "list_id"
    t.date "date"
    t.text "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "venue_id"
    t.boolean "manual_entry", default: false
    t.string "venue_name"
    t.integer "neighborhood_id"
    t.integer "venuetype_id"
    t.index ["list_id"], name: "index_list_items_on_list_id"
    t.index ["neighborhood_id"], name: "index_list_items_on_neighborhood_id"
    t.index ["venue_id"], name: "index_list_items_on_venue_id"
    t.index ["venuetype_id"], name: "index_list_items_on_venuetype_id"
  end

  create_table "lists", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.boolean "private"
    t.string "title"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "showmap", default: true
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "neighborhoods", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "parent_neighborhood_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "rating"
    t.integer "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["venue_id"], name: "index_ratings_on_venue_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "parent_tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "to_tries", id: :serial, force: :cascade do |t|
    t.integer "venue_id"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_to_tries_on_user_id"
    t.index ["venue_id"], name: "index_to_tries_on_venue_id"
  end

  create_table "tries", id: :serial, force: :cascade do |t|
    t.integer "venue_id"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_tries_on_user_id"
    t.index ["venue_id"], name: "index_tries_on_venue_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "admin", default: false
    t.string "avatar"
    t.string "firstname"
    t.string "lastname"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "venues", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "tags", default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "street"
    t.string "city"
    t.string "state"
    t.integer "neighborhood_id"
    t.boolean "byob"
    t.integer "price"
    t.boolean "craftbeer"
    t.boolean "cocktails"
    t.boolean "latenight"
    t.boolean "cashonly"
    t.float "latitude"
    t.float "longitude"
    t.boolean "outdoor"
  end

  add_foreign_key "list_items", "neighborhoods"
  add_foreign_key "list_items", "tags", column: "venuetype_id"
end
