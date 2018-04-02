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

ActiveRecord::Schema.define(version: 20180331113447) do

  create_table "attendance_records", force: :cascade do |t|
    t.date     "month_start_date"
    t.integer  "standard_id",      limit: 4
    t.text     "attendance_hash",  limit: 65535
    t.integer  "student_id",       limit: 4
    t.string   "defaulter",        limit: 255
    t.string   "weightage",        limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "location",        limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "signatory_email", limit: 255
  end

  create_table "standards", force: :cascade do |t|
    t.integer  "school_id",           limit: 4
    t.string   "class_name",          limit: 255
    t.float    "min_attendance_mark", limit: 24
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "standard_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "school_id",   limit: 4
  end

end
