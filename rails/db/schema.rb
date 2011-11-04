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

ActiveRecord::Schema.define(:version => 20111104042654) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "pages", :force => true do |t|
    t.string   "identifier"
    t.string   "name"
    t.string   "category"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages_people", :id => false, :force => true do |t|
    t.integer "person_id"
    t.integer "page_id"
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "identifier"
    t.string   "access_token"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "preference"
    t.string   "first_name"
    t.string   "gender"
    t.string   "birthday"
    t.string   "relationship_status"
    t.integer  "digital_capital"
  end

  add_index "people", ["identifier"], :name => "people_identifier_index"

end
