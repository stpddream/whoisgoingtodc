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

ActiveRecord::Schema.define(version: 20140126005234) do

  create_table "events", force: true do |t|
    t.string   "where"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "visibility"
  end

  create_table "friends", force: true do |t|
    t.integer  "friender_id"
    t.integer  "friended_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friends", ["friended_id"], name: "index_friends_on_friended_id"
  add_index "friends", ["friender_id", "friended_id"], name: "index_friends_on_friender_id_and_friended_id", unique: true
  add_index "friends", ["friender_id"], name: "index_friends_on_friender_id"

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
