# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_04_100337) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order", default: 0, null: false
    t.integer "region", default: 0, null: false
    t.index ["order"], name: "index_areas_on_order"
    t.index ["region"], name: "index_areas_on_region"
  end

  create_table "date_types", force: :cascade do |t|
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

  create_table "plan_spots", force: :cascade do |t|
    t.bigint "plan_id", null: false
    t.bigint "spot_id", null: false
    t.integer "order", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id", "order"], name: "index_plan_spots_on_plan_id_and_order", unique: true
    t.index ["plan_id", "spot_id"], name: "index_plan_spots_on_plan_id_and_spot_id", unique: true
    t.index ["plan_id"], name: "index_plan_spots_on_plan_id"
    t.index ["spot_id"], name: "index_plan_spots_on_spot_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "title", null: false
    t.string "description", null: false
    t.bigint "area_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total_budget", default: 0, null: false
    t.string "thumb", default: "https://date-suggester.s3-ap-northeast-1.amazonaws.com/plan_default.jpg", null: false
    t.index ["area_id"], name: "index_plans_on_area_id"
    t.index ["total_budget"], name: "index_plans_on_total_budget"
  end

  create_table "spots", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.integer "budget", null: false
    t.integer "tel"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "thumb", default: "https://date-suggester.s3-ap-northeast-1.amazonaws.com/spot_default.jpg", null: false
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
    t.string "email"
    t.string "password_digest"
    t.string "token", null: false
    t.string "name"
    t.integer "birth_year", null: false
    t.integer "gender"
    t.bigint "area_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_users_on_area_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["token"], name: "index_users_on_token", unique: true
  end

  add_foreign_key "my_plans", "plans"
  add_foreign_key "my_plans", "users"
  add_foreign_key "plan_spots", "plans"
  add_foreign_key "plan_spots", "spots"
  add_foreign_key "plans", "areas"
  add_foreign_key "users", "areas"
end
