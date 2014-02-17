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

ActiveRecord::Schema.define(version: 20140217174248) do

  create_table "comments", force: true do |t|
    t.integer  "commenterid"
    t.text     "body"
    t.integer  "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["venue_id"], name: "index_comments_on_venue_id"

  create_table "neighborhoods", force: true do |t|
    t.string   "name"
    t.integer  "parentneighborhoodid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", force: true do |t|
    t.integer  "raterid"
    t.integer  "rating"
    t.integer  "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["venue_id"], name: "index_ratings_on_venue_id"

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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "venues", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "typeid"
    t.string   "yelpid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.integer  "neighborhoodid"
    t.boolean  "byob"
    t.integer  "price"
    t.boolean  "craftbeer"
    t.boolean  "cocktails"
    t.boolean  "latenight"
  end

  create_table "venuetypes", force: true do |t|
    t.string   "name"
    t.integer  "parenttypeid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
