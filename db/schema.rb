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

ActiveRecord::Schema[7.1].define(version: 2024_04_05_144735) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "matches", force: :cascade do |t|
    t.date "date"
    t.string "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches_teams", id: false, force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "team_id", null: false
    t.index ["match_id"], name: "index_matches_teams_on_match_id"
    t.index ["team_id"], name: "index_matches_teams_on_team_id"
  end

  create_table "performances", force: :cascade do |t|
    t.bigint "type_performance_id", null: false
    t.bigint "player_id", null: false
    t.bigint "match_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_performances_on_match_id"
    t.index ["player_id"], name: "index_performances_on_player_id"
    t.index ["type_performance_id", "player_id", "match_id"], name: "idx_on_type_performance_id_player_id_match_id_14d5d045bb", unique: true
    t.index ["type_performance_id"], name: "index_performances_on_type_performance_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "type_performances", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["description"], name: "index_type_performances_on_description", unique: true
  end

  add_foreign_key "performances", "matches"
  add_foreign_key "performances", "players"
  add_foreign_key "performances", "type_performances"
  add_foreign_key "players", "teams"
end
