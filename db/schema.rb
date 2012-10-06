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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121006050612) do

  create_table "courses", :force => true do |t|
    t.string   "department"
    t.integer  "class_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "downloaded_bies", :force => true do |t|
    t.string   "user_email"
    t.integer  "note_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "content"
  end

  add_index "downloaded_bies", ["user_email"], :name => "index_downloaded_bies_on_user_email"

  create_table "notes", :force => true do |t|
    t.string   "department"
    t.integer  "class_num"
    t.integer  "nid"
    t.string   "content"
    t.integer  "number_downloads"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "user_id"
  end

  add_index "notes", ["class_num", "content", "department", "nid"], :name => "index_notes_on_class_num_and_content_and_department_and_nid"

  create_table "uploaded_bies", :force => true do |t|
    t.string   "user_email"
    t.integer  "note_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "content"
  end

  add_index "uploaded_bies", ["user_email"], :name => "index_uploaded_bies_on_user_email"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
