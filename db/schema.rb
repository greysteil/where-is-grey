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

ActiveRecord::Schema.define(version: 20160730230824) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "check_ins", force: :cascade do |t|
    t.string   "message_type",                           null: false
    t.string   "spot_id",                                null: false
    t.datetime "sent_at",                                null: false
    t.decimal  "latitude",      precision: 16, scale: 6, null: false
    t.decimal  "longitude",     precision: 16, scale: 6, null: false
    t.string   "battery_state",                          null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["spot_id"], name: "index_check_ins_on_spot_id", unique: true, using: :btree
  end

end
