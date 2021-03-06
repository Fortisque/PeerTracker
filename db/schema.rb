# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150504103019) do

  create_table "assignments", force: :cascade do |t|
    t.string   "assignment_name"
    t.integer  "course_id"
    t.datetime "deadline"
    t.datetime "created_at",                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           null: false
    t.datetime "updated_at",                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           null: false
    t.text     "instructions",    default: "This form is an opportunity for you to rate the performance of your team members on this iteration.  Please fill this form out to the best of your abilities.  Letting us know of issues within your team (e.g. unequal distribution of work, people not cooperating with the rest of the team, etc) allows the staff to be aware of them and help you fix them. You have 20*X points to distribute, where X is the total number of members in your group. The idea is that if someone did an average amount of work, they would get 20 points.  The sum of all points you give to yourself and your teammates need to sum to 20*X. All of the numbers and comments you give are private and only viewable by the staff."
    t.text     "description"
  end

  create_table "courses", force: :cascade do |t|
    t.string  "course_name"
    t.integer "user_id"
    t.integer "team_size",   default: 4
    t.text    "description"
  end

  create_table "courses_users", id: false, force: :cascade do |t|
    t.integer "course_id"
    t.integer "user_id"
  end

  add_index "courses_users", ["course_id"], name: "index_courses_users_on_course_id"
  add_index "courses_users", ["user_id"], name: "index_courses_users_on_user_id"

  create_table "credentials", force: :cascade do |t|
    t.integer "uid"
    t.integer "course_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.text    "comments"
    t.integer "rating"
    t.integer "giver_id"
    t.integer "receiver_id"
    t.integer "assignment_id"
    t.integer "team_id"
  end

  add_index "feedbacks", ["assignment_id"], name: "index_feedbacks_on_assignment_id"
  add_index "feedbacks", ["team_id"], name: "index_feedbacks_on_team_id"

  create_table "models", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "models", ["email"], name: "index_models_on_email", unique: true
  add_index "models", ["reset_password_token"], name: "index_models_on_reset_password_token", unique: true

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "teams", force: :cascade do |t|
    t.string  "name"
    t.integer "course_id"
    t.integer "group_number", default: 0
  end

  create_table "teams_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "team_id"
  end

  add_index "teams_users", ["team_id"], name: "index_teams_users_on_team_id"
  add_index "teams_users", ["user_id"], name: "index_teams_users_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.integer  "user_id"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
