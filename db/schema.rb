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

ActiveRecord::Schema[8.0].define(version: 2025_04_29_185257) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  create_table "contestants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "status", default: "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "season_number"
    t.string "tribe"
    t.index ["name"], name: "index_contestants_on_name", unique: true
  end

  create_table "draft_contestants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "draft_id", null: false
    t.uuid "contestant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contestant_id"], name: "index_draft_contestants_on_contestant_id"
    t.index ["draft_id", "contestant_id"], name: "index_draft_contestants_on_draft_id_and_contestant_id", unique: true
    t.index ["draft_id"], name: "index_draft_contestants_on_draft_id"
  end

  create_table "draft_players", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "draft_id", null: false
    t.uuid "player_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["draft_id", "player_id"], name: "index_draft_players_on_draft_id_and_player_id", unique: true
    t.index ["draft_id"], name: "index_draft_players_on_draft_id"
    t.index ["player_id"], name: "index_draft_players_on_player_id"
  end

  create_table "drafts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "season_number", null: false
    t.uuid "draft_owner_id", null: false
    t.integer "episodes_count", null: false
    t.datetime "airing_datetime", null: false
    t.boolean "votes_first_episode", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["airing_datetime"], name: "index_drafts_on_airing_datetime"
    t.index ["draft_owner_id"], name: "index_drafts_on_draft_owner_id"
    t.index ["season_number"], name: "index_drafts_on_season_number"
  end

  create_table "episodes", force: :cascade do |t|
    t.integer "number", null: false
    t.datetime "air_date", null: false
    t.datetime "voting_deadline", null: false
    t.integer "duration", default: 90, null: false
    t.integer "season_number", null: false
    t.string "status", default: "upcoming", null: false
    t.boolean "is_final", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "draft_id"
    t.index ["number"], name: "index_episodes_on_number", unique: true
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "role", default: "player", null: false
    t.string "status", default: "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "contestant_id", null: false
    t.bigint "episode_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contestant_id"], name: "index_votes_on_contestant_id"
    t.index ["episode_id"], name: "index_votes_on_episode_id"
    t.index ["user_id", "contestant_id"], name: "index_votes_on_user_id_and_contestant_id", unique: true
    t.index ["user_id", "episode_id"], name: "index_votes_on_user_id_and_episode_id", unique: true
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "draft_contestants", "contestants"
  add_foreign_key "draft_contestants", "drafts"
  add_foreign_key "draft_players", "drafts"
  add_foreign_key "draft_players", "users", column: "player_id"
  add_foreign_key "drafts", "users", column: "draft_owner_id"
  add_foreign_key "votes", "contestants"
  add_foreign_key "votes", "episodes"
  add_foreign_key "votes", "users"
end
