ActiveRecord::Schema.define(version: 20180525182539) do

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

  create_table "specialties", force: :cascade do |t|
    t.string   "name"
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
