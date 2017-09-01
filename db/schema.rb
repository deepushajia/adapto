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

ActiveRecord::Schema.define(version: 20170827163101) do

  create_table "attempt_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "option_id"
    t.integer  "score"
    t.integer  "time_taken"
    t.integer  "generated_test_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "topic_id"
  end

  create_table "courses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean  "active"
    t.string   "name"
    t.text     "icon",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "generated_test_questions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "generated_test_id"
    t.integer  "question_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "generated_tests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "test_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "options", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "question_id"
    t.boolean  "correct"
    t.integer  "no_selected"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "option",      limit: 65535
  end

  create_table "performance_tests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "test_no"
    t.float    "proficiency",    limit: 24
    t.float    "accuracy",       limit: 24
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "no_correct"
    t.integer  "no_wrong"
    t.integer  "no_unattempted"
  end

  create_table "performance_topics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.integer  "test_no"
    t.float    "proficiency",     limit: 24
    t.float    "accuracy",        limit: 24
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "total_attempted"
    t.integer  "total_seen"
  end

  create_table "questions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "topic_id"
    t.boolean  "active"
    t.text     "question",     limit: 65535
    t.integer  "difficulty"
    t.integer  "no_taken"
    t.integer  "no_correct"
    t.integer  "no_wrong"
    t.integer  "average_time"
    t.text     "solution",     limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["average_time"], name: "average_time", unique: true, using: :btree
  end

  create_table "topics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "course_id"
    t.boolean  "active"
    t.string   "name"
    t.text     "icon",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "full_name"
    t.string   "email"
    t.text     "hash_password",        limit: 65535
    t.string   "authentication_token"
    t.string   "uid"
    t.string   "phone_no"
    t.boolean  "active"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

