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

ActiveRecord::Schema.define(version: 20180608205444) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lawyers", force: :cascade do |t|
    t.string   "name"
    t.string   "phone_number"
    t.string   "website"
    t.string   "address"
    t.integer  "avvo_rating"
    t.boolean  "is_avvo_pro"
    t.integer  "number_of_avvo_legal_answers"
    t.integer  "number_of_avvo_legal_guides"
    t.integer  "number_of_avvo_reviews"
    t.integer  "number_of_years_licensed"
    t.boolean  "offers_free_consultation"
    t.string   "email_address"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "lawyers_specialties", id: false, force: :cascade do |t|
    t.integer "lawyer_id",                                 null: false
    t.integer "specialty_id",                              null: false
    t.integer "percent_of_business_is_this_specialty"
    t.integer "number_of_years_working_in_this_specialty"
  end

  add_index "lawyers_specialties", ["lawyer_id"], name: "index_lawyers_specialties_on_lawyer_id", using: :btree
  add_index "lawyers_specialties", ["specialty_id"], name: "index_lawyers_specialties_on_specialty_id", using: :btree

  create_table "specialties", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.string   "symbol"
    t.string   "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "urls", force: :cascade do |t|
    t.string   "url"
    t.string   "url_type"
    t.string   "domain"
    t.datetime "last_crawled"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
