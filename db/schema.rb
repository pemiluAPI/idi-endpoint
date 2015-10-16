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

ActiveRecord::Schema.define(version: 20150929063449) do

  create_table "indicator_variables", force: true do |t|
    t.integer  "time_serie_id"
    t.integer  "indicator_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "indicator_variables", ["indicator_id"], name: "index_indicator_variables_on_indicator_id", using: :btree
  add_index "indicator_variables", ["time_serie_id"], name: "index_indicator_variables_on_time_serie_id", using: :btree

  create_table "indicators", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "provinces", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_series", force: true do |t|
    t.integer  "province_id"
    t.string   "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "time_series", ["province_id"], name: "index_time_series_on_province_id", using: :btree

end
