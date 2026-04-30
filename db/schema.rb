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

ActiveRecord::Schema[8.1].define(version: 2026_04_30_002247) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "jlpt_levels", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "level_description", null: false
    t.integer "position", null: false
    t.datetime "updated_at", null: false
    t.index ["level_description"], name: "index_jlpt_levels_on_level_description", unique: true
    t.index ["position"], name: "index_jlpt_levels_on_position", unique: true
    t.check_constraint "\"position\" > 0", name: "position_check"
  end

  create_table "kanjis", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "jlpt_level_id", null: false
    t.string "kanji", null: false
    t.string "kun_reading"
    t.string "meaning", null: false
    t.text "mnemonic"
    t.string "on_reading"
    t.datetime "updated_at", null: false
    t.index ["jlpt_level_id"], name: "index_kanjis_on_jlpt_level_id"
    t.index ["kanji"], name: "index_kanjis_on_kanji", unique: true
  end

  create_table "review_cards", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.float "ease_factor", default: 2.5, null: false
    t.integer "interval", default: 0, null: false
    t.datetime "next_review", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "repetitions", default: 0, null: false
    t.bigint "reviewable_id", null: false
    t.string "reviewable_type", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["reviewable_type", "reviewable_id"], name: "index_review_cards_on_reviewable"
    t.index ["user_id", "next_review"], name: "index_review_cards_on_user_id_and_next_review"
    t.index ["user_id"], name: "index_review_cards_on_user_id"
  end

  create_table "review_logs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.float "ease_factor"
    t.integer "interval"
    t.integer "quality"
    t.integer "response_time_ms"
    t.bigint "reviewable_id", null: false
    t.string "reviewable_type", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["reviewable_type", "reviewable_id"], name: "index_review_logs_on_reviewable"
    t.index ["user_id"], name: "index_review_logs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "kanjis", "jlpt_levels"
  add_foreign_key "review_cards", "users"
  add_foreign_key "review_logs", "users"
end
