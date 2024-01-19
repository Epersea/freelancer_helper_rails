# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_01_19_153057) do
  create_table "rates", force: :cascade do |t|
    t.float "rate"
    t.integer "annual_expenses"
    t.integer "hours_day"
    t.float "hours_year"
    t.integer "billable_percent"
    t.integer "net_month"
    t.float "tax_percent"
    t.integer "gross_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "user_info", default: {}
  end

end
