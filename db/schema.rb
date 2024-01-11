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

ActiveRecord::Schema[7.1].define(version: 2024_01_11_173622) do
  create_table "rates", force: :cascade do |t|
    t.float "rate"
    t.float "annual_expenses"
    t.float "hours_day"
    t.float "hours_year"
    t.float "billable_percent"
    t.float "net_month"
    t.float "tax_percent"
    t.float "gross_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
