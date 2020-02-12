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

ActiveRecord::Schema.define(version: 2020_02_12_045132) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "my_plans", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "plan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_my_plans_on_plan_id"
    t.index ["user_id"], name: "index_my_plans_on_user_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "title", null: false
    t.string "description", null: false
    t.bigint "area_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_plans_on_area_id"
  end

  create_table "spots", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.string "budget", null: false
    t.string "tel"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_types", force: :cascade do |t|
    t.integer "tens_place_age", null: false
    t.integer "early_or_late", null: false
    t.integer "standard_budget", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["early_or_late"], name: "index_user_types_on_early_or_late"
    t.index ["tens_place_age", "early_or_late"], name: "index_user_types_on_tens_place_age_and_early_or_late", unique: true
    t.index ["tens_place_age"], name: "index_user_types_on_tens_place_age"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "token", null: false
    t.string "name"
    t.integer "birth_year", null: false
    t.integer "gender", null: false
    t.bigint "area_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_users_on_area_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["token"], name: "index_users_on_token", unique: true
  end

  add_foreign_key "my_plans", "plans"
  add_foreign_key "my_plans", "users"
  add_foreign_key "plans", "areas"
  add_foreign_key "users", "areas"
end
