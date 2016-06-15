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

ActiveRecord::Schema.define(version: 20160615184607) do

  create_table "artworks", force: :cascade do |t|
    t.string   "location_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artworks", ["location_id"], name: "index_artworks_on_location_id"

  create_table "comments", force: :cascade do |t|
    t.string   "url"
    t.string   "location_id", null: false
    t.string   "artist_name"
    t.string   "link"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["artist_name"], name: "index_comments_on_artist_name"
  add_index "comments", ["location_id"], name: "index_comments_on_location_id"
  add_index "comments", ["url"], name: "index_comments_on_url"

  create_table "locations", force: :cascade do |t|
    t.string   "street1",    null: false
    t.string   "street2"
    t.string   "mapcode",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["mapcode"], name: "index_locations_on_mapcode"
  add_index "locations", ["street1"], name: "index_locations_on_street1"
  add_index "locations", ["street2"], name: "index_locations_on_street2"

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "login_token"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["login_token"], name: "index_users_on_login_token"
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
