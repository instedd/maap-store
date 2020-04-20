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

ActiveRecord::Schema.define(version: 2020_04_20_153254) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "antibiotic_consumption_stats", force: :cascade do |t|
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "antibiotic_id"
    t.boolean "issued"
    t.integer "quantity"
    t.integer "balance"
    t.string "recipient_facility"
    t.string "recipient_unit"
    t.bigint "site_id"
    t.datetime "deleted_at"
    t.index ["antibiotic_id"], name: "index_antibiotic_consumption_stats_on_antibiotic_id"
    t.index ["deleted_at"], name: "index_antibiotic_consumption_stats_on_deleted_at"
    t.index ["site_id"], name: "index_antibiotic_consumption_stats_on_site_id"
  end

  create_table "antibiotics", force: :cascade do |t|
    t.string "name"
    t.string "strength_value"
    t.string "strength_unit"
    t.string "form"
    t.string "pack_size"
    t.string "brand"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clinical_services", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "culture_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "electronic_pharmacy_stock_records", force: :cascade do |t|
    t.integer "header_row"
    t.integer "data_rows_from"
    t.integer "data_rows_to"
    t.jsonb "columns"
    t.jsonb "phi"
    t.jsonb "date"
    t.bigint "site_id"
    t.integer "obfuscation_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "s3_file_path"
    t.string "file_name"
    t.string "error_message"
    t.datetime "uploaded_at"
    t.string "raw_error_message"
    t.index ["site_id"], name: "index_electronic_pharmacy_stock_records_on_site_id"
  end

  create_table "lab_record_imports", force: :cascade do |t|
    t.integer "header_row"
    t.integer "data_rows_from"
    t.integer "data_rows_to"
    t.jsonb "columns"
    t.jsonb "patient_or_lab_record_id"
    t.jsonb "phi"
    t.jsonb "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "site_id"
    t.string "patient_id_state", default: "pending"
    t.string "s3_file_path"
    t.string "file_name"
    t.string "error_message"
    t.datetime "uploaded_at"
    t.string "raw_error_message"
    t.index ["site_id"], name: "index_lab_record_imports_on_site_id"
  end

  create_table "lab_records", force: :cascade do |t|
    t.bigint "lab_record_import_id"
    t.bigint "site_id"
    t.integer "patient_id_state", default: 0
    t.integer "row"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "patient_id"
    t.index ["lab_record_import_id"], name: "index_lab_records_on_lab_record_import_id"
    t.index ["site_id"], name: "index_lab_records_on_site_id"
  end

  create_table "patient_entries", force: :cascade do |t|
    t.bigint "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "department"
    t.string "admission_date"
    t.string "discharge_date"
    t.string "weight"
    t.string "height"
    t.string "chief_complaint"
    t.boolean "patient_transferred"
    t.string "primary_diagnosis"
    t.string "primary_diagnosis_icd_code"
    t.boolean "antibiotics_prescribed"
    t.boolean "patient_was_on_an_indwelling_medical_device"
    t.string "medical_device"
    t.string "infection_acquisition"
    t.string "discharge_diagnostic"
    t.string "discharge_diagnostic_icd_code"
    t.string "patient_outcome_at_discharge"
    t.bigint "stay_timespan"
    t.bigint "patient_location_id"
    t.string "pregnancy_status"
    t.string "premature_birth"
    t.string "comorbidities"
    t.string "antibiotic_when"
    t.string "prescribed_antibiotics_list"
    t.integer "age_value"
    t.string "age_unit"
    t.index ["patient_id"], name: "index_patient_entries_on_patient_id"
    t.index ["patient_location_id"], name: "index_patient_entries_on_patient_location_id"
  end

  create_table "patient_id_hashes", force: :cascade do |t|
    t.string "patient_id"
    t.string "hashed_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "site_id"
    t.index ["patient_id"], name: "index_patient_id_hashes_on_patient_id"
    t.index ["site_id"], name: "index_patient_id_hashes_on_site_id"
  end

  create_table "patient_locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patients", force: :cascade do |t|
    t.string "gender"
    t.integer "year_of_birth"
    t.string "level_of_education"
    t.string "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "site_id"
    t.string "patient_id_state", default: "pending"
    t.index ["site_id"], name: "index_patients_on_site_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "ownership"
    t.boolean "has_pharmacy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "level"
    t.boolean "has_hospital"
    t.boolean "has_laboratory"
    t.string "site_type"
    t.integer "available_beds"
    t.integer "outpatient_by_month"
    t.string "services_served_by_lab", array: true
    t.boolean "has_patient_uid"
    t.string "system_change"
    t.boolean "has_infection_disease_department"
    t.integer "infectious_diseases_physicians"
    t.integer "infectious_diseases_nurses"
    t.boolean "has_amr_comitee"
    t.string "meet_frequency"
    t.boolean "has_annual_antibiogram"
    t.string "stew_team"
    t.boolean "has_guideline_antibiotics"
    t.boolean "has_av_spec_processed"
    t.integer "av_spec_processed"
    t.integer "av_spec_bacterial_grow"
    t.datetime "last_visit"
    t.string "registration_number"
    t.string "registration_body"
    t.boolean "has_cms"
    t.string "location_type"
    t.string "contact_name"
    t.string "contact_designation"
    t.string "contact_email"
    t.string "contact_number"
    t.string "record_keeping_system"
    t.string "other_services"
    t.boolean "is_specialty_hospital"
    t.string "specialties", array: true
    t.string "other_specialties"
    t.string "served_population_size"
    t.integer "average_patients_per_year"
    t.string "average_icu_length_of_stay"
    t.boolean "patient_uid_in_lab_records"
    t.string "system_change_details"
    t.integer "av_spec_fungal_processed"
    t.integer "av_spec_fungal_grow"
    t.boolean "frequented_community_pharmacies"
    t.string "community_pharmacies_details"
    t.string "pharmacy_contact_name"
    t.string "pharmacy_contact_designation"
    t.string "pharmacy_contact_email"
    t.string "pharmacy_contact_number"
    t.string "pharmacy_records_keeping"
    t.string "pharmacy_data_extraction_records", array: true
    t.string "cms_dispatch_destinations"
    t.string "cms_dispatch_frequency"
    t.boolean "cms_collect_stock"
    t.string "cms_facility_collector_details"
  end

  create_table "specimen_sources", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "antibiotic_consumption_stats", "antibiotics"
  add_foreign_key "antibiotic_consumption_stats", "sites"
  add_foreign_key "electronic_pharmacy_stock_records", "sites"
  add_foreign_key "lab_record_imports", "sites"
  add_foreign_key "lab_records", "lab_record_imports"
  add_foreign_key "lab_records", "sites"
  add_foreign_key "patient_entries", "patient_locations"
  add_foreign_key "patient_entries", "patients"
  add_foreign_key "patient_id_hashes", "sites"
  add_foreign_key "patients", "sites"
end
