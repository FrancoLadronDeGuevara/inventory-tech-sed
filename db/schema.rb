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

ActiveRecord::Schema[8.0].define(version: 2025_08_25_111837) do
  create_table "articulos", force: :cascade do |t|
    t.string "modelo", null: false
    t.string "marca", null: false
    t.date "fecha_ingreso", null: false
    t.integer "portador_actual_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["portador_actual_id"], name: "index_articulos_on_portador_actual_id"
  end

  create_table "personas", force: :cascade do |t|
    t.string "nombre", null: false
    t.string "apellido", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "transferencias", force: :cascade do |t|
    t.integer "articulo_id", null: false
    t.integer "portador_anterior_id"
    t.integer "portador_nuevo_id", null: false
    t.datetime "fecha_transferencia"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["articulo_id"], name: "index_transferencias_on_articulo_id"
    t.index ["portador_anterior_id"], name: "index_transferencias_on_portador_anterior_id"
    t.index ["portador_nuevo_id"], name: "index_transferencias_on_portador_nuevo_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "articulos", "personas", column: "portador_actual_id"
  add_foreign_key "sessions", "users"
  add_foreign_key "transferencias", "articulos"
  add_foreign_key "transferencias", "personas", column: "portador_anterior_id"
  add_foreign_key "transferencias", "personas", column: "portador_nuevo_id"
end
