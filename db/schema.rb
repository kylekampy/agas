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

ActiveRecord::Schema.define(:version => 20120503014041) do

  create_table "addresses", :force => true do |t|
    t.string   "zip"
    t.string   "street"
    t.string   "state"
    t.string   "country"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "city"
  end

  create_table "administrators", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "appointments", :force => true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "phy_id"
    t.integer  "pat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bills", :force => true do |t|
    t.string   "unique_hash"
    t.string   "status"
    t.float    "price"
    t.float    "insurance_coverage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emails", :force => true do |t|
    t.string   "email_type"
    t.string   "email"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emergency_contacts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "patient_id"
  end

  create_table "health_prices", :force => true do |t|
    t.string   "insure_code"
    t.float    "cost"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logins", :force => true do |t|
    t.string   "username"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_staffs", :force => true do |t|
    t.string   "firstname"
    t.string   "middlename"
    t.string   "lastname"
    t.integer  "doc_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patients", :force => true do |t|
    t.integer  "primary_phy_id"
    t.date     "date_of_birth"
    t.integer  "pharmacy_id"
    t.integer  "insurance_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "firstname"
    t.string   "middlename"
    t.string   "lastname"
    t.integer  "second_physician_id"
    t.string   "gender"
  end

  create_table "phones", :force => true do |t|
    t.string   "phone_type"
    t.string   "phone"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "physicians", :force => true do |t|
    t.string   "specialty"
    t.string   "office_num"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "firstname"
    t.string   "middlename"
    t.string   "lastname"
  end

  create_table "schedules", :force => true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "phy_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
