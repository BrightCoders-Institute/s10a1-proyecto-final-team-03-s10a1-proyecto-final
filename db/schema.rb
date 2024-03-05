# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_03_05_010503) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "followers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "follower_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follower_user_id"], name: "index_followers_on_follower_user_id"
    t.index ["user_id"], name: "index_followers_on_user_id"
  end

  create_table "routines", force: :cascade do |t|
    t.string "exercise"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_routines_on_user_id"
  end

  create_table "series", force: :cascade do |t|
    t.integer "repetitions"
    t.float "weight"
    t.bigint "routine_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["routine_id"], name: "index_series_on_routine_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "lastName"
    t.date "birthday"
    t.float "weight"
    t.float "height"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "followers", "users"
  add_foreign_key "followers", "users", column: "follower_user_id"
  add_foreign_key "routines", "users"
  add_foreign_key "series", "routines"
end
