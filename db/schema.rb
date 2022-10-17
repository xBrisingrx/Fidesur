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

ActiveRecord::Schema.define(version: 2022_10_12_194304) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "apples", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "code"
    t.decimal "hectares", precision: 15, scale: 2, default: "0.0"
    t.string "location"
    t.float "value", default: 0.0
    t.boolean "active", default: true
    t.bigint "sector_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "space_not_available", precision: 15, scale: 2, default: "0.0", comment: "Espacio de la manzana que no puede ser utilizado"
    t.index ["sector_id"], name: "index_apples_on_sector_id"
  end

  create_table "batch_payments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "number", null: false
    t.decimal "money", precision: 15, scale: 2, default: "0.0", null: false
    t.decimal "total", precision: 15, scale: 2, default: "0.0"
    t.boolean "active", default: true
    t.date "due_date"
    t.date "pay_date"
    t.boolean "payed", default: false
    t.bigint "sale_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "owes", precision: 15, scale: 2, default: "0.0"
    t.decimal "payment", precision: 15, scale: 2, default: "0.0"
    t.text "comment"
    t.decimal "interest", precision: 15, scale: 2, default: "0.0"
    t.integer "pay_status", default: 0
    t.decimal "ajuste", precision: 15, scale: 2, default: "0.0"
    t.text "comment_ajuste"
    t.index ["sale_id"], name: "index_batch_payments_on_sale_id"
  end

  create_table "cash_registers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "product"
    t.integer "activity"
    t.decimal "value", precision: 15, scale: 2, default: "0.0"
    t.text "detail"
    t.text "comment"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "client_sales", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.bigint "client_id"
    t.bigint "sale_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_client_sales_on_client_id"
    t.index ["sale_id"], name: "index_client_sales_on_sale_id"
  end

  create_table "clients", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "code", comment: "Legajo"
    t.string "name"
    t.string "last_name"
    t.integer "dni"
    t.string "direction"
    t.string "email"
    t.string "phone"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "currencies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name", limit: 40
    t.string "detail"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fee_payments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "fee_id"
    t.date "pay_date"
    t.bigint "currency_id"
    t.decimal "payment", precision: 15, scale: 2, default: "0.0"
    t.decimal "tomado_en", precision: 15, scale: 2, default: "1.0"
    t.decimal "total", precision: 15, scale: 2, default: "0.0"
    t.string "pay_name", default: ""
    t.text "comment", default: "''"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id"], name: "index_fee_payments_on_currency_id"
    t.index ["fee_id"], name: "index_fee_payments_on_fee_id"
  end

  create_table "fees", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "sale_id"
    t.integer "number", null: false
    t.decimal "value", precision: 15, scale: 2, default: "0.0", null: false
    t.decimal "total_value", precision: 15, scale: 2, default: "0.0"
    t.date "due_date"
    t.date "pay_date"
    t.decimal "owes", precision: 15, scale: 2, default: "0.0"
    t.decimal "payment", precision: 15, scale: 2, default: "0.0"
    t.text "comment", default: "''"
    t.decimal "interest", precision: 15, scale: 2, default: "0.0"
    t.integer "pay_status", default: 0
    t.decimal "adjust", precision: 15, scale: 2, default: "0.0"
    t.text "comment_adjust", default: "''"
    t.boolean "payed", default: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sale_id"], name: "index_fees_on_sale_id"
  end

  create_table "field_sales", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.bigint "field_id"
    t.bigint "sale_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["field_id"], name: "index_field_sales_on_field_id"
    t.index ["sale_id"], name: "index_field_sales_on_sale_id"
  end

  create_table "fields", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "code"
    t.string "measures"
    t.decimal "surface", precision: 15, scale: 2, default: "0.0"
    t.string "ubication"
    t.decimal "price", precision: 15, scale: 2, default: "0.0"
    t.integer "status", default: 0
    t.bigint "apple_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "field_type", default: 0
    t.boolean "is_green_space", default: false
    t.bigint "user_created_id", default: 1
    t.bigint "user_updated_id", default: 1
    t.index ["apple_id"], name: "index_fields_on_apple_id"
    t.index ["user_created_id"], name: "index_fields_on_user_created_id"
    t.index ["user_updated_id"], name: "index_fields_on_user_updated_id"
  end

  create_table "land_fee_payments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.bigint "land_fee_id"
    t.date "pay_date"
    t.decimal "payment", precision: 15, scale: 2, default: "0.0"
    t.text "comment"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "tomado_en", precision: 15, scale: 2, default: "0.0", null: false
    t.decimal "total", precision: 15, scale: 2, default: "0.0", null: false
    t.bigint "currency_id"
    t.string "pay_name"
    t.index ["currency_id"], name: "index_land_fee_payments_on_currency_id"
    t.index ["land_fee_id"], name: "index_land_fee_payments_on_land_fee_id"
  end

  create_table "land_fees", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.bigint "sale_id"
    t.integer "number", null: false
    t.decimal "fee_value", precision: 15, scale: 2, default: "0.0", null: false
    t.decimal "total_value", precision: 15, scale: 2, default: "0.0"
    t.date "due_date"
    t.date "pay_date"
    t.decimal "owes", precision: 15, scale: 2, default: "0.0"
    t.decimal "payment", precision: 15, scale: 2, default: "0.0"
    t.text "comment"
    t.decimal "interest", precision: 15, scale: 2, default: "0.0"
    t.integer "pay_status", default: 0
    t.decimal "adjust", precision: 15, scale: 2, default: "0.0"
    t.text "comment_adjust"
    t.boolean "payed", default: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sale_id"], name: "index_land_fees_on_sale_id"
  end

  create_table "lands", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "code"
    t.string "measures"
    t.decimal "surface", precision: 15, scale: 2, default: "0.0"
    t.string "ubication"
    t.decimal "price", precision: 15, scale: 2, default: "0.0"
    t.integer "status", default: 0
    t.integer "land_type", default: 0
    t.boolean "is_green_space", default: false
    t.decimal "space_not_available", precision: 15, scale: 2, default: "0.0", comment: "Espacio de el lote que no puede ser utilizado"
    t.bigint "apple_id"
    t.bigint "user_created_id"
    t.bigint "user_updated_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_corner", default: false
    t.index ["apple_id"], name: "index_lands_on_apple_id"
    t.index ["user_created_id"], name: "index_lands_on_user_created_id"
    t.index ["user_updated_id"], name: "index_lands_on_user_updated_id"
  end

  create_table "materials", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "active", default: true
    t.bigint "user_created_id"
    t.bigint "user_updated_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_created_id"], name: "index_materials_on_user_created_id"
    t.index ["user_updated_id"], name: "index_materials_on_user_updated_id"
  end

  create_table "project_materials", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "material_id"
    t.bigint "user_created_id"
    t.bigint "user_updated_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_id"], name: "index_project_materials_on_material_id"
    t.index ["project_id"], name: "index_project_materials_on_project_id"
    t.index ["user_created_id"], name: "index_project_materials_on_user_created_id"
    t.index ["user_updated_id"], name: "index_project_materials_on_user_updated_id"
  end

  create_table "project_providers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "provider_id"
    t.bigint "user_created_id"
    t.bigint "user_updated_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_providers_on_project_id"
    t.index ["provider_id"], name: "index_project_providers_on_provider_id"
    t.index ["user_created_id"], name: "index_project_providers_on_user_created_id"
    t.index ["user_updated_id"], name: "index_project_providers_on_user_updated_id"
  end

  create_table "project_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "active", default: true
    t.bigint "user_created_id"
    t.bigint "user_updated_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_created_id"], name: "index_project_types_on_user_created_id"
    t.index ["user_updated_id"], name: "index_project_types_on_user_updated_id"
  end

  create_table "projects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "number", null: false
    t.string "name"
    t.string "tecnical_direction"
    t.bigint "provider_id"
    t.bigint "material_id"
    t.bigint "project_type_id"
    t.decimal "price", precision: 15, scale: 2, default: "0.0", null: false
    t.integer "status"
    t.bigint "user_created_id"
    t.bigint "user_updated_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["material_id"], name: "index_projects_on_material_id"
    t.index ["project_type_id"], name: "index_projects_on_project_type_id"
    t.index ["provider_id"], name: "index_projects_on_provider_id"
    t.index ["user_created_id"], name: "index_projects_on_user_created_id"
    t.index ["user_updated_id"], name: "index_projects_on_user_updated_id"
  end

  create_table "providers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "cuit"
    t.string "description"
    t.string "activity"
    t.boolean "active", default: true
    t.bigint "user_created_id"
    t.bigint "user_updated_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_created_id"], name: "index_providers_on_user_created_id"
    t.index ["user_updated_id"], name: "index_providers_on_user_updated_id"
  end

  create_table "sale_products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "sale_id"
    t.string "product_type"
    t.bigint "product_id"
    t.text "comment"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_type", "product_id"], name: "index_sale_products_on_product_type_and_product_id"
    t.index ["sale_id"], name: "index_sale_products_on_sale_id"
  end

  create_table "sales", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.decimal "paid", precision: 15, scale: 2, default: "0.0"
    t.decimal "total_cost", precision: 15, scale: 2, default: "0.0"
    t.integer "number_of_payments"
    t.integer "arrear"
    t.integer "due_date"
    t.boolean "apply_arrear"
    t.text "comment"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "sale_date"
  end

  create_table "sales_payments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.decimal "value", precision: 15, scale: 2, default: "0.0", null: false
    t.decimal "tomado_en", precision: 15, scale: 2, default: "0.0", null: false
    t.decimal "value_in_pesos", precision: 15, scale: 2, default: "0.0", null: false
    t.string "detail"
    t.bigint "sale_id"
    t.bigint "currency_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pay_name"
    t.index ["currency_id"], name: "index_sales_payments_on_currency_id"
    t.index ["sale_id"], name: "index_sales_payments_on_sale_id"
  end

  create_table "sectors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name"
    t.decimal "size", precision: 15, scale: 2, default: "0.0"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "username"
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.integer "rol"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "apples", "sectors"
  add_foreign_key "batch_payments", "sales"
  add_foreign_key "client_sales", "clients"
  add_foreign_key "client_sales", "sales"
  add_foreign_key "fee_payments", "currencies"
  add_foreign_key "fee_payments", "fees"
  add_foreign_key "fees", "sales"
  add_foreign_key "field_sales", "fields"
  add_foreign_key "field_sales", "sales"
  add_foreign_key "fields", "apples"
  add_foreign_key "fields", "users", column: "user_created_id"
  add_foreign_key "fields", "users", column: "user_updated_id"
  add_foreign_key "land_fee_payments", "currencies"
  add_foreign_key "land_fee_payments", "land_fees"
  add_foreign_key "land_fees", "sales"
  add_foreign_key "lands", "apples"
  add_foreign_key "lands", "users", column: "user_created_id"
  add_foreign_key "lands", "users", column: "user_updated_id"
  add_foreign_key "materials", "users", column: "user_created_id"
  add_foreign_key "materials", "users", column: "user_updated_id"
  add_foreign_key "project_materials", "materials"
  add_foreign_key "project_materials", "projects"
  add_foreign_key "project_materials", "users", column: "user_created_id"
  add_foreign_key "project_materials", "users", column: "user_updated_id"
  add_foreign_key "project_providers", "projects"
  add_foreign_key "project_providers", "providers"
  add_foreign_key "project_providers", "users", column: "user_created_id"
  add_foreign_key "project_providers", "users", column: "user_updated_id"
  add_foreign_key "project_types", "users", column: "user_created_id"
  add_foreign_key "project_types", "users", column: "user_updated_id"
  add_foreign_key "projects", "materials"
  add_foreign_key "projects", "project_types"
  add_foreign_key "projects", "providers"
  add_foreign_key "projects", "users", column: "user_created_id"
  add_foreign_key "projects", "users", column: "user_updated_id"
  add_foreign_key "providers", "users", column: "user_created_id"
  add_foreign_key "providers", "users", column: "user_updated_id"
  add_foreign_key "sale_products", "sales"
  add_foreign_key "sales_payments", "currencies"
  add_foreign_key "sales_payments", "sales"
end
