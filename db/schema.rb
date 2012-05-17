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

ActiveRecord::Schema.define(:version => 20120516214017) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "attributes", :force => true do |t|
    t.integer "relative_id"
    t.string  "relative_type"
    t.hstore  "data_ru"
    t.hstore  "data_en"
  end

  add_index "attributes", ["data_en"], :name => "attributes_gist_data_en"
  add_index "attributes", ["data_ru"], :name => "attributes_gist_data_ru"
  add_index "attributes", ["relative_id"], :name => "index_attributes_on_relative_id"

  create_table "cities", :force => true do |t|
    t.string  "title_ru"
    t.string  "title_en"
    t.string  "slug"
    t.integer "region_id"
    t.boolean "delta",     :default => true, :null => false
  end

  add_index "cities", ["slug"], :name => "index_cities_on_slug", :unique => true

  create_table "hotel_types", :force => true do |t|
    t.string   "title_ru"
    t.string   "title_en"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "hotels", :force => true do |t|
    t.integer  "city_id"
    t.string   "title_ru"
    t.string   "title_en"
    t.text     "description_ru"
    t.text     "description_en"
    t.string   "address_ru"
    t.string   "address_en"
    t.string   "slug"
    t.integer  "hotel_type_id"
    t.boolean  "delta",          :default => true, :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "hotels", ["city_id"], :name => "index_hotels_on_city_id"
  add_index "hotels", ["hotel_type_id"], :name => "index_hotels_on_hotel_type_id"
  add_index "hotels", ["slug"], :name => "index_hotels_on_slug", :unique => true

  create_table "news", :force => true do |t|
    t.string   "title_ru"
    t.string   "title_en"
    t.text     "body_ru"
    t.text     "body_en"
    t.string   "slug"
    t.integer  "created_by_id"
    t.integer  "published_by_id"
    t.datetime "published_at"
    t.boolean  "is_published"
    t.boolean  "delta",           :default => true, :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "news", ["created_by_id"], :name => "index_news_on_created_by_id"
  add_index "news", ["published_by_id"], :name => "index_news_on_published_by_id"
  add_index "news", ["slug"], :name => "index_news_on_slug", :unique => true

  create_table "pages", :force => true do |t|
    t.string   "title_ru"
    t.string   "title_en"
    t.text     "body_ru"
    t.text     "body_en"
    t.string   "slug"
    t.string   "category",        :default => "other", :null => false
    t.integer  "created_by_id"
    t.integer  "published_by_id"
    t.datetime "published_at"
    t.boolean  "is_published"
    t.boolean  "delta",           :default => true,    :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.boolean  "visible_ru",      :default => false,   :null => false
    t.boolean  "visible_en",      :default => false,   :null => false
  end

  add_index "pages", ["created_by_id"], :name => "index_pages_on_created_by_id"
  add_index "pages", ["published_by_id"], :name => "index_pages_on_published_by_id"
  add_index "pages", ["slug"], :name => "index_pages_on_slug", :unique => true

  create_table "photos", :force => true do |t|
    t.integer  "relative_id"
    t.string   "relative_type"
    t.string   "title_ru"
    t.string   "title_en"
    t.string   "image"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "photos", ["relative_id"], :name => "index_photos_on_relative_id"

  create_table "promotions", :force => true do |t|
    t.string   "title_ru"
    t.string   "title_en"
    t.string   "caption_ru"
    t.string   "caption_en"
    t.string   "image"
    t.string   "url"
    t.integer  "tour_id"
    t.integer  "hotel_id"
    t.string   "url_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "promotions", ["hotel_id"], :name => "index_promotions_on_hotel_id"
  add_index "promotions", ["tour_id"], :name => "index_promotions_on_tour_id"

  create_table "regions", :force => true do |t|
    t.string   "title_ru"
    t.string   "title_en"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "slug"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "regions", ["parent_id"], :name => "index_regions_on_parent_id"
  add_index "regions", ["slug"], :name => "index_regions_on_slug", :unique => true

  create_table "tours", :force => true do |t|
    t.string   "title_ru"
    t.string   "title_en"
    t.text     "description_ru"
    t.text     "description_en"
    t.string   "slug"
    t.boolean  "delta",          :default => true, :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "tours", ["slug"], :name => "index_tours_on_slug", :unique => true

end
