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

ActiveRecord::Schema[7.0].define(version: 2024_04_24_165326) do
  create_table "assembled_exam_questions", force: :cascade do |t|
    t.integer "practice_exam_id", null: false
    t.integer "question_id", null: false
    t.integer "question_choice_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["practice_exam_id"], name: "index_assembled_exam_questions_on_practice_exam_id"
    t.index ["question_choice_id"], name: "index_assembled_exam_questions_on_question_choice_id"
    t.index ["question_id"], name: "index_assembled_exam_questions_on_question_id"
  end

  create_table "exams", force: :cascade do |t|
    t.string "name"
    t.integer "max_num_questions"
    t.integer "max_duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "practice_exams", force: :cascade do |t|
    t.integer "exam_id", null: false
    t.integer "user_id", null: false
    t.integer "custom_max_num_questions", null: false
    t.integer "custom_max_duration", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time"
    t.float "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exam_id"], name: "index_practice_exams_on_exam_id"
    t.index ["user_id"], name: "index_practice_exams_on_user_id"
  end

  create_table "question_choices", force: :cascade do |t|
    t.string "response", null: false
    t.boolean "is_correct", null: false
    t.integer "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_question_choices_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "exam_id", null: false
    t.string "prompt", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exam_id"], name: "index_questions_on_exam_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "assembled_exam_questions", "practice_exams"
  add_foreign_key "assembled_exam_questions", "question_choices"
  add_foreign_key "assembled_exam_questions", "questions"
  add_foreign_key "practice_exams", "exams"
  add_foreign_key "practice_exams", "users"
  add_foreign_key "question_choices", "questions"
  add_foreign_key "questions", "exams"
end
