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

ActiveRecord::Schema[7.1].define(version: 2024_01_04_145643) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "content_pages", force: :cascade do |t|
    t.string "slug"
    t.string "title"
    t.string "intro"
    t.string "content_list"
    t.string "markdown"
    t.string "author"
    t.string "description"
    t.integer "parent_id"
    t.integer "previous_id"
    t.integer "next_id"
    t.integer "position"
    t.boolean "is_published", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["position", "parent_id"], name: "index_content_pages_on_position_and_parent_id", unique: true
    t.index ["title"], name: "index_content_pages_on_title", unique: true
  end

end
