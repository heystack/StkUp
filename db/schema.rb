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

ActiveRecord::Schema.define(:version => 20110903030322) do

  create_table "answers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "stack_id"
    t.integer  "choice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["stack_id"], :name => "index_answers_on_stack_id"
  add_index "answers", ["user_id"], :name => "index_answers_on_user_id"

  create_table "interests", :force => true do |t|
    t.integer  "interest_id"
    t.string   "interest_desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "interests", ["interest_id"], :name => "index_interests_on_interest_id"

  create_table "stacks", :force => true do |t|
    t.integer  "interest_id"
    t.string   "question"
    t.string   "question_subtext"
    t.string   "chart_type"
    t.string   "choice_picker_type"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stacks", ["created_by"], :name => "index_stacks_on_created_by"

  create_table "user_interests", :force => true do |t|
    t.integer  "user_id"
    t.integer  "interest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_interests", ["interest_id"], :name => "index_user_interests_on_interest_id"
  add_index "user_interests", ["user_id", "interest_id"], :name => "index_user_interests_on_user_id_and_interest_id", :unique => true
  add_index "user_interests", ["user_id"], :name => "index_user_interests_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
