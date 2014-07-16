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

ActiveRecord::Schema.define(version: 20140618110306) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "activities", force: true do |t|
    t.string   "title"
    t.text     "about"
    t.integer  "price"
    t.text     "bookmsg"
    t.integer  "duration"
    t.boolean  "active",      default: true
    t.integer  "merchant_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["category_id"], name: "index_activities_on_category_id", using: :btree
  add_index "activities", ["merchant_id"], name: "index_activities_on_merchant_id", using: :btree

  create_table "activities_addresses", id: false, force: true do |t|
    t.integer "activity_id"
    t.integer "address_id"
  end

  add_index "activities_addresses", ["activity_id", "address_id"], name: "index_activities_addresses_on_activity_id_and_address_id", using: :btree
  add_index "activities_addresses", ["address_id", "activity_id"], name: "index_activities_addresses_on_address_id_and_activity_id", using: :btree

  create_table "activities_hosts", force: true do |t|
    t.integer "activity_id"
    t.integer "host_id"
  end

  add_index "activities_hosts", ["activity_id"], name: "index_activities_hosts_on_activity_id", using: :btree
  add_index "activities_hosts", ["host_id"], name: "index_activities_hosts_on_host_id", using: :btree

  create_table "addresses", force: true do |t|
    t.string   "address"
    t.string   "phone"
    t.string   "locality"
    t.string   "province"
    t.string   "country"
    t.decimal  "lat"
    t.decimal  "lng"
    t.integer  "merchant_id"
    t.integer  "slot_id"
    t.integer  "rule_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["merchant_id"], name: "index_addresses_on_merchant_id", using: :btree
  add_index "addresses", ["rule_id"], name: "index_addresses_on_rule_id", using: :btree
  add_index "addresses", ["slot_id"], name: "index_addresses_on_slot_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "attachinary_files", force: true do |t|
    t.integer  "attachinariable_id"
    t.string   "attachinariable_type"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachinary_files", ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent", using: :btree

  create_table "bookings", force: true do |t|
    t.text     "optional"
    t.datetime "cancel"
    t.string   "name"
    t.string   "email"
    t.boolean  "friend",     default: false
    t.boolean  "confirm",    default: false
    t.string   "phone"
    t.integer  "slot_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bookings", ["slot_id"], name: "index_bookings_on_slot_id", using: :btree
  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "follows", force: true do |t|
    t.integer  "merchant_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["merchant_id"], name: "index_follows_on_merchant_id", using: :btree
  add_index "follows", ["user_id"], name: "index_follows_on_user_id", using: :btree

  create_table "hosts", force: true do |t|
    t.string   "title"
    t.string   "job"
    t.text     "description"
    t.integer  "merchant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hosts", ["merchant_id"], name: "index_hosts_on_merchant_id", using: :btree

  create_table "identities", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "likes", force: true do |t|
    t.integer  "activity_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["activity_id"], name: "index_likes_on_activity_id", using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "merchants", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "description"
    t.string   "phone"
    t.string   "site"
    t.string   "opening"
  end

  add_index "merchants", ["email"], name: "index_merchants_on_email", unique: true, using: :btree
  add_index "merchants", ["reset_password_token"], name: "index_merchants_on_reset_password_token", unique: true, using: :btree

  create_table "messages", force: true do |t|
    t.string   "content"
    t.boolean  "mu"
    t.integer  "user_id"
    t.integer  "merchant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["merchant_id"], name: "index_messages_on_merchant_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "rules", force: true do |t|
    t.text     "description"
    t.integer  "inventory"
    t.boolean  "is_all_day"
    t.date     "from_date"
    t.time     "from_time"
    t.date     "to_date"
    t.time     "to_time"
    t.string   "repeats"
    t.integer  "repeats_every_n_days"
    t.integer  "repeats_every_n_weeks"
    t.integer  "repeats_weekly_each_days_of_the_week_mask"
    t.integer  "repeats_every_n_months"
    t.string   "repeats_monthly"
    t.integer  "repeats_monthly_each_days_of_the_month_mask"
    t.integer  "repeats_monthly_on_ordinals_mask"
    t.integer  "repeats_monthly_on_days_of_the_week_mask"
    t.integer  "repeats_every_n_years"
    t.integer  "repeats_yearly_each_months_of_the_year_mask"
    t.boolean  "repeats_yearly_on"
    t.integer  "repeats_yearly_on_ordinals_mask"
    t.integer  "repeats_yearly_on_days_of_the_week_mask"
    t.string   "repeat_ends"
    t.date     "repeat_ends_on"
    t.string   "time_zone",                                   default: "Hong Kong"
    t.integer  "activity_id"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rules", ["activity_id"], name: "index_rules_on_activity_id", using: :btree
  add_index "rules", ["address_id"], name: "index_rules_on_address_id", using: :btree

  create_table "shares", force: true do |t|
    t.string   "receiver"
    t.text     "message"
    t.integer  "user_id"
    t.integer  "activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shares", ["activity_id"], name: "index_shares_on_activity_id", using: :btree
  add_index "shares", ["user_id"], name: "index_shares_on_user_id", using: :btree

  create_table "slots", force: true do |t|
    t.text     "description"
    t.integer  "inventory"
    t.boolean  "is_all_day"
    t.datetime "start"
    t.datetime "finish"
    t.integer  "activity_id"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "slots", ["activity_id"], name: "index_slots_on_activity_id", using: :btree
  add_index "slots", ["address_id"], name: "index_slots_on_address_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "views", force: true do |t|
    t.integer  "activity_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "views", ["activity_id"], name: "index_views_on_activity_id", using: :btree
  add_index "views", ["user_id"], name: "index_views_on_user_id", using: :btree

end
