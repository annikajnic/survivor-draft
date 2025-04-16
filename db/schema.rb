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

ActiveRecord::Schema[8.0].define(version: 2025_04_15_215635) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "contestants", force: :cascade do |t|
    t.string "name", null: false
    t.string "status", default: "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_contestants_on_name", unique: true
  end

  create_table "episodes", force: :cascade do |t|
    t.integer "number", null: false
    t.datetime "air_date", null: false
    t.datetime "voting_deadline", null: false
    t.string "status", default: "upcoming", null: false
    t.boolean "is_final", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_episodes_on_number", unique: true
  end

  create_table "final_predictions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "contestant_id", null: false
    t.integer "placement", null: false
    t.integer "jury_votes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contestant_id"], name: "index_final_predictions_on_contestant_id"
    t.index ["user_id", "placement"], name: "index_final_predictions_on_user_id_and_placement", unique: true
    t.index ["user_id"], name: "index_final_predictions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "user", null: false
    t.string "status", default: "active", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "contestant_id", null: false
    t.bigint "episode_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contestant_id"], name: "index_votes_on_contestant_id"
    t.index ["episode_id"], name: "index_votes_on_episode_id"
    t.index ["user_id", "contestant_id"], name: "index_votes_on_user_id_and_contestant_id", unique: true
    t.index ["user_id", "episode_id"], name: "index_votes_on_user_id_and_episode_id", unique: true
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "final_predictions", "contestants"
  add_foreign_key "final_predictions", "users"
  add_foreign_key "votes", "contestants"
  add_foreign_key "votes", "episodes"
  add_foreign_key "votes", "users"
end
