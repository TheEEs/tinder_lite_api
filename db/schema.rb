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

ActiveRecord::Schema.define(version: 2019_12_16_030327) do

  create_table "device_tokens", force: :cascade do |t|
    t.string "token"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_device_tokens_on_user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.string "follower_type"
    t.integer "follower_id"
    t.string "followable_type"
    t.integer "followable_id"
    t.datetime "created_at"
    t.index ["followable_id", "followable_type"], name: "fk_followables"
    t.index ["follower_id", "follower_type"], name: "fk_follows"
  end

  create_table "likes", force: :cascade do |t|
    t.string "liker_type"
    t.integer "liker_id"
    t.string "likeable_type"
    t.integer "likeable_id"
    t.datetime "created_at"
    t.index ["likeable_id", "likeable_type"], name: "fk_likeables"
    t.index ["liker_id", "liker_type"], name: "fk_likes"
  end

  create_table "matches", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches_users", id: false, force: :cascade do |t|
    t.integer "match_id"
    t.integer "user_id"
    t.index ["match_id"], name: "index_matches_users_on_match_id"
    t.index ["user_id"], name: "index_matches_users_on_user_id"
  end

  create_table "mentions", force: :cascade do |t|
    t.string "mentioner_type"
    t.integer "mentioner_id"
    t.string "mentionable_type"
    t.integer "mentionable_id"
    t.datetime "created_at"
    t.index ["mentionable_id", "mentionable_type"], name: "fk_mentionables"
    t.index ["mentioner_id", "mentioner_type"], name: "fk_mentions"
  end

  create_table "table_users_matches", force: :cascade do |t|
    t.integer "user_id"
    t.integer "match_id"
    t.index ["match_id"], name: "index_table_users_matches_on_match_id"
    t.index ["user_id"], name: "index_table_users_matches_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "identifier"
    t.string "avatar"
    t.date "date_of_birdth"
    t.boolean "gender"
    t.text "intro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["identifier"], name: "index_users_on_identifier", unique: true
  end

end
