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

ActiveRecord::Schema[7.0].define(version: 2023_07_02_183852) do
  create_table "batch_users", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "batch_id", null: false
    t.boolean "active", default: true, null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_batch_users_on_active"
    t.index ["batch_id"], name: "index_batch_users_on_batch_id"
    t.index ["status"], name: "index_batch_users_on_status"
    t.index ["user_id"], name: "index_batch_users_on_user_id"
  end

  create_table "batches", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "active", default: true, null: false
    t.integer "school_course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_batches_on_active"
    t.index ["name"], name: "index_batches_on_name"
    t.index ["school_course_id"], name: "index_batches_on_school_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "active", default: true, null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_courses_on_active"
    t.index ["name"], name: "index_courses_on_name"
    t.index ["slug"], name: "index_courses_on_slug"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_roles_on_active"
  end

  create_table "school_courses", force: :cascade do |t|
    t.integer "school_id", null: false
    t.integer "course_id", null: false
    t.boolean "enabled", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_school_courses_on_course_id"
    t.index ["enabled"], name: "index_school_courses_on_enabled"
    t.index ["school_id"], name: "index_school_courses_on_school_id"
  end

  create_table "school_users", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "school_id", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_school_users_on_active"
    t.index ["school_id"], name: "index_school_users_on_school_id"
    t.index ["user_id"], name: "index_school_users_on_user_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "active", default: true, null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_schools_on_active"
    t.index ["name"], name: "index_schools_on_name"
    t.index ["slug"], name: "index_schools_on_slug"
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_users_on_active"
    t.index ["email"], name: "index_users_on_email"
  end

  add_foreign_key "batch_users", "batches"
  add_foreign_key "batch_users", "users"
  add_foreign_key "batches", "school_courses"
  add_foreign_key "school_courses", "courses"
  add_foreign_key "school_courses", "schools"
  add_foreign_key "school_users", "schools"
  add_foreign_key "school_users", "users"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
