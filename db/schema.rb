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

ActiveRecord::Schema.define(version: 2020_05_20_021729) do

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "quiz_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_favorites_on_quiz_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "impressions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "quiz_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_impressions_on_quiz_id"
    t.index ["user_id"], name: "index_impressions_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "visitor_id", null: false
    t.integer "visited_id", null: false
    t.integer "quiz_id"
    t.integer "quiz_comment_id"
    t.string "action", null: false
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_comment_id"], name: "index_notifications_on_quiz_comment_id"
    t.index ["quiz_id"], name: "index_notifications_on_quiz_id"
    t.index ["visited_id"], name: "index_notifications_on_visited_id"
    t.index ["visitor_id"], name: "index_notifications_on_visitor_id"
  end

  create_table "quiz_comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "quiz_id", null: false
    t.text "comment", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_quiz_comments_on_quiz_id"
    t.index ["user_id"], name: "index_quiz_comments_on_user_id"
  end

  create_table "quiz_tags", force: :cascade do |t|
    t.integer "quiz_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_quiz_tags_on_quiz_id"
    t.index ["tag_id"], name: "index_quiz_tags_on_tag_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "question", null: false
    t.string "answer", null: false
    t.text "explanation"
    t.string "quiz_image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category"
    t.index ["user_id"], name: "index_quizzes_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id", null: false
    t.integer "followed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "nick_name"
    t.text "introduction"
    t.string "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
