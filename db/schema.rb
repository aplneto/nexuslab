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

ActiveRecord::Schema[7.1].define(version: 2023_11_22_010327) do
  create_table "invitations", force: :cascade do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.index ["project_id"], name: "index_invitations_on_project_id"
    t.index ["user_id"], name: "index_invitations_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "title", limit: 100, null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "project_files", force: :cascade do |t|
    t.string "filename", limit: 100, null: false
    t.integer "project_id"
    t.integer "user_id"
    t.text "path", null: false
    t.index ["project_id"], name: "index_project_files_on_project_id"
    t.index ["user_id"], name: "index_project_files_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title", limit: 100, null: false
    t.boolean "is_public", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.text "abstract"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "faq"
    t.text "answer"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", limit: 100, null: false
    t.string "name", limit: 200, null: false
    t.string "username", limit: 20, null: false
    t.string "password", limit: 32, null: false
    t.boolean "is_admin", default: false
    t.string "profile_picture", limit: 200
    t.text "about"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "invitations", "projects"
  add_foreign_key "invitations", "users"
  add_foreign_key "project_files", "projects"
  add_foreign_key "project_files", "users"
end
