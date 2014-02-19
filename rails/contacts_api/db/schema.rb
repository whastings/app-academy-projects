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

ActiveRecord::Schema.define(version: 20140219013844) do

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "contact_id"
    t.string   "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["contact_id", "user_id"], name: "index_comments_on_contact_id_and_user_id"
  add_index "comments", ["contact_id"], name: "index_comments_on_contact_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "contact_shares", force: true do |t|
    t.integer  "contact_id",                 null: false
    t.integer  "user_id",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "favorite",   default: false
  end

  add_index "contact_shares", ["contact_id", "user_id"], name: "index_contact_shares_on_contact_id_and_user_id", unique: true
  add_index "contact_shares", ["contact_id"], name: "index_contact_shares_on_contact_id"
  add_index "contact_shares", ["favorite"], name: "index_contact_shares_on_favorite"
  add_index "contact_shares", ["user_id"], name: "index_contact_shares_on_user_id"

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "favorite",   default: false
  end

  add_index "contacts", ["favorite"], name: "index_contacts_on_favorite"
  add_index "contacts", ["user_id"], name: "index_contacts_on_user_id"

  create_table "group_memberships", force: true do |t|
    t.integer  "group_id"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_memberships", ["contact_id", "group_id"], name: "index_group_memberships_on_contact_id_and_group_id", unique: true
  add_index "group_memberships", ["contact_id"], name: "index_group_memberships_on_contact_id"
  add_index "group_memberships", ["group_id"], name: "index_group_memberships_on_group_id"

  create_table "groups", force: true do |t|
    t.string   "group_name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["user_id"], name: "index_groups_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
