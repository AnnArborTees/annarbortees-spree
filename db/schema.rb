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

ActiveRecord::Schema.define(version: 20160504154454) do

  create_table "spree_adjustments", force: true do |t|
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "adjustable_id"
    t.string   "adjustable_type"
    t.decimal  "amount",          precision: 10, scale: 2
    t.string   "label"
    t.boolean  "mandatory"
    t.boolean  "eligible",                                 default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.integer  "order_id"
    t.boolean  "included",                                 default: false
  end

  add_index "spree_adjustments", ["adjustable_id"], name: "index_adjustments_on_order_id", using: :btree
  add_index "spree_adjustments", ["source_type", "source_id"], name: "index_spree_adjustments_on_source_type_and_source_id", using: :btree

  create_table "spree_amazon_fps_checkouts", force: true do |t|
    t.string   "transaction_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "customer_name"
    t.string   "refund_transaction_id"
    t.datetime "refunded_at"
    t.integer  "payment_method_id"
  end

  create_table "spree_api_settings", force: true do |t|
    t.string "type"
    t.string "homepage"
    t.string "api_endpoint"
    t.string "auth_email"
    t.string "auth_token"
  end

  add_index "spree_api_settings", ["type"], name: "index_spree_api_settings_on_type", unique: true, using: :btree

  create_table "spree_assets", force: true do |t|
    t.integer  "viewable_id"
    t.string   "viewable_type"
    t.integer  "attachment_width"
    t.integer  "attachment_height"
    t.integer  "attachment_file_size"
    t.integer  "position"
    t.string   "attachment_content_type"
    t.string   "attachment_file_name"
    t.string   "type",                    limit: 75
    t.datetime "attachment_updated_at"
    t.text     "alt"
    t.integer  "option_value_id"
    t.boolean  "thumbnail"
  end

  add_index "spree_assets", ["option_value_id"], name: "index_spree_assets_on_option_value_id", using: :btree
  add_index "spree_assets", ["thumbnail"], name: "index_spree_assets_on_thumbnail", using: :btree
  add_index "spree_assets", ["viewable_id"], name: "index_assets_on_viewable_id", using: :btree
  add_index "spree_assets", ["viewable_type", "type"], name: "index_assets_on_viewable_type_and_type", using: :btree

  create_table "spree_calculators", force: true do |t|
    t.string   "type"
    t.integer  "calculable_id"
    t.string   "calculable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_calculators", ["calculable_id", "calculable_type"], name: "index_spree_calculators_on_calculable_id_and_calculable_type", using: :btree
  add_index "spree_calculators", ["id", "type"], name: "index_spree_calculators_on_id_and_type", using: :btree

  create_table "spree_commission_agents", force: true do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.string   "calculator_type"
    t.decimal  "rate",            precision: 4,  scale: 2
    t.decimal  "max",             precision: 10, scale: 2
    t.decimal  "min",             precision: 4,  scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_commission_payments", force: true do |t|
    t.decimal  "amount",           precision: 10, scale: 2
    t.date     "bring_current_at"
    t.integer  "user_id"
    t.string   "payment_method"
    t.string   "transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_commission_payments", ["user_id"], name: "index_spree_commission_payments_on_user_id", using: :btree

  create_table "spree_commissions", force: true do |t|
    t.decimal  "amount",              precision: 10, scale: 2
    t.integer  "commission_agent_id"
    t.integer  "line_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_configurations", force: true do |t|
    t.string   "name"
    t.string   "type",       limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_configurations", ["name", "type"], name: "index_spree_configurations_on_name_and_type", using: :btree

  create_table "spree_countries", force: true do |t|
    t.string   "iso_name"
    t.string   "iso"
    t.string   "iso3"
    t.string   "name"
    t.integer  "numcode"
    t.boolean  "states_required", default: false
    t.datetime "updated_at"
  end

  create_table "spree_credit_cards", force: true do |t|
    t.string   "month"
    t.string   "year"
    t.string   "cc_type"
    t.string   "last_digits"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "address_id"
    t.string   "gateway_customer_profile_id"
    t.string   "gateway_payment_profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "user_id"
    t.integer  "payment_method_id"
  end

  add_index "spree_credit_cards", ["payment_method_id"], name: "index_spree_credit_cards_on_payment_method_id", using: :btree
  add_index "spree_credit_cards", ["user_id"], name: "index_spree_credit_cards_on_user_id", using: :btree

  create_table "spree_digital_links", force: true do |t|
    t.integer  "digital_id"
    t.integer  "line_item_id"
    t.string   "secret"
    t.integer  "access_counter"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_digital_links", ["digital_id"], name: "index_spree_digital_links_on_digital_id", using: :btree
  add_index "spree_digital_links", ["line_item_id"], name: "index_spree_digital_links_on_line_item_id", using: :btree
  add_index "spree_digital_links", ["secret"], name: "index_spree_digital_links_on_secret", using: :btree

  create_table "spree_digitals", force: true do |t|
    t.integer  "variant_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_digitals", ["variant_id"], name: "index_spree_digitals_on_variant_id", using: :btree

  create_table "spree_gateways", force: true do |t|
    t.string   "type"
    t.string   "name"
    t.text     "description"
    t.boolean  "active",      default: true
    t.string   "environment", default: "development"
    t.string   "server",      default: "test"
    t.boolean  "test_mode",   default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_google_products", force: true do |t|
    t.string   "google_product_category"
    t.string   "condition"
    t.boolean  "adult"
    t.boolean  "automatically_update"
    t.integer  "variant_id"
    t.string   "product_id"
    t.datetime "last_insertion_date"
    t.text     "last_insertion_errors"
    t.text     "last_insertion_warnings"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "age_group"
    t.string   "size_type"
    t.string   "product_type"
  end

  add_index "spree_google_products", ["variant_id"], name: "index_spree_google_products_on_variant_id", using: :btree

  create_table "spree_google_shopping_settings", force: true do |t|
    t.string   "merchant_id"
    t.string   "oauth2_client_id"
    t.string   "oauth2_client_secret"
    t.string   "current_access_token"
    t.string   "current_refresh_token"
    t.datetime "current_expiration_date"
    t.boolean  "use_google_shopping"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "google_api_application_name"
    t.string   "current_host"
  end

  create_table "spree_google_trusted_store_settings", force: true do |t|
    t.string   "account_id"
    t.string   "default_locale"
    t.datetime "last_shipment_upload"
    t.datetime "last_cancellation_upload"
  end

  create_table "spree_homepage_products", force: true do |t|
    t.integer  "product_id"
    t.integer  "homepage_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_homepage_products", ["homepage_id"], name: "index_spree_homepage_products_on_homepage_id", using: :btree
  add_index "spree_homepage_products", ["product_id"], name: "index_spree_homepage_products_on_product_id", using: :btree

  create_table "spree_homepage_slides", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "label"
    t.string   "text"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "active"
  end

  add_index "spree_homepage_slides", ["name"], name: "index_spree_homepage_slides_on_name", using: :btree

  create_table "spree_homepages", force: true do |t|
    t.string   "name"
    t.integer  "store_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_homepages", ["store_id"], name: "index_spree_homepages_on_store_id", using: :btree

  create_table "spree_inventory_units", force: true do |t|
    t.string   "state"
    t.integer  "variant_id"
    t.integer  "order_id"
    t.integer  "shipment_id"
    t.integer  "return_authorization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "pending",                 default: true
    t.integer  "line_item_id"
  end

  add_index "spree_inventory_units", ["line_item_id"], name: "index_spree_inventory_units_on_line_item_id", using: :btree
  add_index "spree_inventory_units", ["order_id"], name: "index_inventory_units_on_order_id", using: :btree
  add_index "spree_inventory_units", ["shipment_id"], name: "index_inventory_units_on_shipment_id", using: :btree
  add_index "spree_inventory_units", ["variant_id"], name: "index_inventory_units_on_variant_id", using: :btree

  create_table "spree_line_items", force: true do |t|
    t.integer  "variant_id"
    t.integer  "order_id"
    t.integer  "quantity",                                                    null: false
    t.decimal  "price",                precision: 8,  scale: 2,               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "currency"
    t.decimal  "cost_price",           precision: 8,  scale: 2
    t.integer  "tax_category_id"
    t.decimal  "adjustment_total",     precision: 10, scale: 2, default: 0.0
    t.decimal  "additional_tax_total", precision: 10, scale: 2, default: 0.0
    t.decimal  "promo_total",          precision: 10, scale: 2, default: 0.0
    t.decimal  "included_tax_total",   precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "pre_tax_amount",       precision: 8,  scale: 2
    t.integer  "store_id"
  end

  add_index "spree_line_items", ["order_id"], name: "index_spree_line_items_on_order_id", using: :btree
  add_index "spree_line_items", ["variant_id"], name: "index_spree_line_items_on_variant_id", using: :btree

  create_table "spree_log_entries", force: true do |t|
    t.integer  "source_id"
    t.string   "source_type"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_mockbot_publisher_steps", force: true do |t|
    t.string  "name"
    t.integer "publisher_id"
  end

  create_table "spree_mockbot_publishers", force: true do |t|
    t.string   "idea_sku"
    t.string   "current_step"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_option_types", force: true do |t|
    t.string   "name",         limit: 100
    t.string   "presentation", limit: 100
    t.integer  "position",                 default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_option_types_prototypes", id: false, force: true do |t|
    t.integer "prototype_id"
    t.integer "option_type_id"
  end

  create_table "spree_option_values", force: true do |t|
    t.integer  "position"
    t.string   "name"
    t.string   "presentation"
    t.integer  "option_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_option_values", ["option_type_id"], name: "index_spree_option_values_on_option_type_id", using: :btree

  create_table "spree_option_values_variants", id: false, force: true do |t|
    t.integer "variant_id"
    t.integer "option_value_id"
  end

  add_index "spree_option_values_variants", ["variant_id", "option_value_id"], name: "index_option_values_variants_on_variant_id_and_option_value_id", using: :btree
  add_index "spree_option_values_variants", ["variant_id"], name: "index_spree_option_values_variants_on_variant_id", using: :btree

  create_table "spree_orders", force: true do |t|
    t.string   "number",                           limit: 32
    t.decimal  "item_total",                                  precision: 10, scale: 2, default: 0.0,     null: false
    t.decimal  "total",                                       precision: 10, scale: 2, default: 0.0,     null: false
    t.string   "state"
    t.decimal  "adjustment_total",                            precision: 10, scale: 2, default: 0.0,     null: false
    t.integer  "user_id"
    t.datetime "completed_at"
    t.integer  "bill_address_id"
    t.integer  "ship_address_id"
    t.decimal  "payment_total",                               precision: 10, scale: 2, default: 0.0
    t.integer  "shipping_method_id"
    t.string   "shipment_state"
    t.string   "payment_state"
    t.string   "email"
    t.text     "special_instructions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "currency"
    t.string   "last_ip_address"
    t.integer  "created_by_id"
    t.decimal  "shipment_total",                              precision: 10, scale: 2, default: 0.0,     null: false
    t.decimal  "additional_tax_total",                        precision: 10, scale: 2, default: 0.0
    t.decimal  "promo_total",                                 precision: 10, scale: 2, default: 0.0
    t.string   "channel",                                                              default: "spree"
    t.decimal  "included_tax_total",                          precision: 10, scale: 2, default: 0.0,     null: false
    t.integer  "item_count",                                                           default: 0
    t.integer  "approver_id"
    t.datetime "approved_at"
    t.boolean  "confirmation_delivered",                                               default: false
    t.boolean  "considered_risky",                                                     default: false
    t.integer  "store_id"
    t.string   "export_state"
    t.boolean  "dont_split_packages_on_backorder",                                     default: false
    t.string   "fraudulent_pp_ref"
  end

  add_index "spree_orders", ["completed_at"], name: "index_spree_orders_on_completed_at", using: :btree
  add_index "spree_orders", ["number"], name: "index_spree_orders_on_number", using: :btree
  add_index "spree_orders", ["user_id", "created_by_id"], name: "index_spree_orders_on_user_id_and_created_by_id", using: :btree
  add_index "spree_orders", ["user_id"], name: "index_spree_orders_on_user_id", using: :btree

  create_table "spree_orders_promotions", id: false, force: true do |t|
    t.integer "order_id"
    t.integer "promotion_id"
  end

  create_table "spree_pages", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "show_in_header",           default: false, null: false
    t.boolean  "show_in_footer",           default: false, null: false
    t.string   "foreign_link"
    t.integer  "position",                 default: 1,     null: false
    t.boolean  "visible",                  default: true
    t.string   "meta_keywords"
    t.string   "meta_description"
    t.string   "layout"
    t.boolean  "show_in_sidebar",          default: false, null: false
    t.string   "meta_title"
    t.boolean  "render_layout_as_partial", default: false
  end

  add_index "spree_pages", ["slug"], name: "index_spree_pages_on_slug", using: :btree

  create_table "spree_payment_capture_events", force: true do |t|
    t.decimal  "amount",     precision: 10, scale: 2, default: 0.0
    t.integer  "payment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_payment_capture_events", ["payment_id"], name: "index_spree_payment_capture_events_on_payment_id", using: :btree

  create_table "spree_payment_methods", force: true do |t|
    t.string   "type"
    t.string   "name"
    t.text     "description"
    t.boolean  "active",       default: true
    t.string   "environment",  default: "development"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_on"
    t.boolean  "auto_capture"
  end

  add_index "spree_payment_methods", ["id", "type"], name: "index_spree_payment_methods_on_id_and_type", using: :btree

  create_table "spree_payments", force: true do |t|
    t.decimal  "amount",               precision: 10, scale: 2, default: 0.0, null: false
    t.integer  "order_id"
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "payment_method_id"
    t.string   "state"
    t.string   "response_code"
    t.string   "avs_response"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "identifier"
    t.string   "cvv_response_code"
    t.string   "cvv_response_message"
  end

  add_index "spree_payments", ["order_id"], name: "index_spree_payments_on_order_id", using: :btree
  add_index "spree_payments", ["payment_method_id"], name: "index_spree_payments_on_payment_method_id", using: :btree

  create_table "spree_paypal_express_checkouts", force: true do |t|
    t.string   "token"
    t.string   "payer_id"
    t.string   "transaction_id"
    t.string   "state",                 default: "complete"
    t.string   "refund_transaction_id"
    t.datetime "refunded_at"
    t.string   "refund_type"
    t.datetime "created_at"
  end

  add_index "spree_paypal_express_checkouts", ["transaction_id"], name: "index_spree_paypal_express_checkouts_on_transaction_id", using: :btree

  create_table "spree_preferences", force: true do |t|
    t.text     "value"
    t.string   "key"
    t.string   "value_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_preferences", ["key"], name: "index_spree_preferences_on_key", unique: true, using: :btree

  create_table "spree_prices", force: true do |t|
    t.integer  "variant_id",                         null: false
    t.decimal  "amount",     precision: 8, scale: 2
    t.string   "currency"
    t.datetime "deleted_at"
  end

  add_index "spree_prices", ["variant_id", "currency"], name: "index_spree_prices_on_variant_id_and_currency", using: :btree

  create_table "spree_product_option_types", force: true do |t|
    t.integer  "position"
    t.integer  "product_id"
    t.integer  "option_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_product_packages", force: true do |t|
    t.integer  "product_id",             null: false
    t.integer  "length",     default: 0, null: false
    t.integer  "width",      default: 0, null: false
    t.integer  "height",     default: 0, null: false
    t.integer  "weight",     default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_product_properties", force: true do |t|
    t.string   "value"
    t.integer  "product_id"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",    default: 0
  end

  add_index "spree_product_properties", ["product_id"], name: "index_product_properties_on_product_id", using: :btree

  create_table "spree_products", force: true do |t|
    t.string   "name",                 default: "",        null: false
    t.text     "description"
    t.datetime "available_on"
    t.datetime "deleted_at"
    t.string   "slug"
    t.text     "meta_description"
    t.string   "meta_keywords"
    t.integer  "tax_category_id"
    t.integer  "shipping_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "layout",               default: "default"
    t.text     "digital_preview"
    t.string   "hashtag"
    t.text     "backorder_details"
    t.string   "vhx_api_key"
  end

  add_index "spree_products", ["available_on"], name: "index_spree_products_on_available_on", using: :btree
  add_index "spree_products", ["deleted_at"], name: "index_spree_products_on_deleted_at", using: :btree
  add_index "spree_products", ["layout"], name: "index_spree_products_on_layout", using: :btree
  add_index "spree_products", ["name"], name: "index_spree_products_on_name", using: :btree
  add_index "spree_products", ["slug"], name: "index_spree_products_on_slug", using: :btree
  add_index "spree_products", ["slug"], name: "permalink_idx_unique", unique: true, using: :btree

  create_table "spree_products_promotion_rules", id: false, force: true do |t|
    t.integer "product_id"
    t.integer "promotion_rule_id"
  end

  add_index "spree_products_promotion_rules", ["product_id"], name: "index_products_promotion_rules_on_product_id", using: :btree
  add_index "spree_products_promotion_rules", ["promotion_rule_id"], name: "index_products_promotion_rules_on_promotion_rule_id", using: :btree

  create_table "spree_products_stores", id: false, force: true do |t|
    t.integer "product_id"
    t.integer "store_id"
  end

  add_index "spree_products_stores", ["product_id"], name: "index_spree_products_stores_on_product_id", using: :btree
  add_index "spree_products_stores", ["store_id"], name: "index_spree_products_stores_on_store_id", using: :btree

  create_table "spree_products_taxons", force: true do |t|
    t.integer "product_id"
    t.integer "taxon_id"
    t.integer "position"
  end

  add_index "spree_products_taxons", ["product_id"], name: "index_spree_products_taxons_on_product_id", using: :btree
  add_index "spree_products_taxons", ["taxon_id"], name: "index_spree_products_taxons_on_taxon_id", using: :btree

  create_table "spree_promotion_action_line_items", force: true do |t|
    t.integer "promotion_action_id"
    t.integer "variant_id"
    t.integer "quantity",            default: 1
  end

  create_table "spree_promotion_actions", force: true do |t|
    t.integer  "promotion_id"
    t.integer  "position"
    t.string   "type"
    t.datetime "deleted_at"
  end

  add_index "spree_promotion_actions", ["deleted_at"], name: "index_spree_promotion_actions_on_deleted_at", using: :btree
  add_index "spree_promotion_actions", ["id", "type"], name: "index_spree_promotion_actions_on_id_and_type", using: :btree
  add_index "spree_promotion_actions", ["promotion_id"], name: "index_spree_promotion_actions_on_promotion_id", using: :btree

  create_table "spree_promotion_rules", force: true do |t|
    t.integer  "promotion_id"
    t.integer  "user_id"
    t.integer  "product_group_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  add_index "spree_promotion_rules", ["product_group_id"], name: "index_promotion_rules_on_product_group_id", using: :btree
  add_index "spree_promotion_rules", ["user_id"], name: "index_promotion_rules_on_user_id", using: :btree

  create_table "spree_promotion_rules_stores", id: false, force: true do |t|
    t.integer "promotion_rule_id"
    t.integer "store_id"
  end

  create_table "spree_promotion_rules_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "promotion_rule_id"
  end

  add_index "spree_promotion_rules_users", ["promotion_rule_id"], name: "index_promotion_rules_users_on_promotion_rule_id", using: :btree
  add_index "spree_promotion_rules_users", ["user_id"], name: "index_promotion_rules_users_on_user_id", using: :btree

  create_table "spree_promotions", force: true do |t|
    t.string   "description"
    t.datetime "expires_at"
    t.datetime "starts_at"
    t.string   "name"
    t.string   "type"
    t.integer  "usage_limit"
    t.string   "match_policy", default: "all"
    t.string   "code"
    t.boolean  "advertise",    default: false
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_promotions", ["id", "type"], name: "index_spree_promotions_on_id_and_type", using: :btree

  create_table "spree_properties", force: true do |t|
    t.string   "name"
    t.string   "presentation", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_properties_prototypes", id: false, force: true do |t|
    t.integer "prototype_id"
    t.integer "property_id"
  end

  create_table "spree_prototypes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_return_authorizations", force: true do |t|
    t.string   "number"
    t.string   "state"
    t.decimal  "amount",            precision: 10, scale: 2, default: 0.0, null: false
    t.integer  "order_id"
    t.text     "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stock_location_id"
  end

  create_table "spree_roles", force: true do |t|
    t.string "name"
  end

  create_table "spree_roles_users", id: false, force: true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "spree_roles_users", ["role_id"], name: "index_spree_roles_users_on_role_id", using: :btree
  add_index "spree_roles_users", ["user_id"], name: "index_spree_roles_users_on_user_id", using: :btree

  create_table "spree_shipments", force: true do |t|
    t.string   "tracking"
    t.string   "number"
    t.decimal  "cost",                 precision: 10, scale: 2, default: 0.0
    t.datetime "shipped_at"
    t.integer  "order_id"
    t.integer  "address_id"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stock_location_id"
    t.decimal  "adjustment_total",     precision: 10, scale: 2, default: 0.0
    t.decimal  "additional_tax_total", precision: 10, scale: 2, default: 0.0
    t.decimal  "promo_total",          precision: 10, scale: 2, default: 0.0
    t.decimal  "included_tax_total",   precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "pre_tax_amount",       precision: 8,  scale: 2
  end

  add_index "spree_shipments", ["number"], name: "index_shipments_on_number", using: :btree
  add_index "spree_shipments", ["order_id"], name: "index_spree_shipments_on_order_id", using: :btree
  add_index "spree_shipments", ["stock_location_id"], name: "index_spree_shipments_on_stock_location_id", using: :btree

  create_table "spree_shipping_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_shipping_method_categories", force: true do |t|
    t.integer  "shipping_method_id",   null: false
    t.integer  "shipping_category_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_shipping_method_categories", ["shipping_category_id", "shipping_method_id"], name: "unique_spree_shipping_method_categories", unique: true, using: :btree
  add_index "spree_shipping_method_categories", ["shipping_method_id"], name: "index_spree_shipping_method_categories_on_shipping_method_id", using: :btree

  create_table "spree_shipping_methods", force: true do |t|
    t.string   "name"
    t.string   "display_on"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tracking_url"
    t.string   "admin_name"
    t.integer  "tax_category_id"
  end

  create_table "spree_shipping_methods_zones", id: false, force: true do |t|
    t.integer "shipping_method_id"
    t.integer "zone_id"
  end

  create_table "spree_shipping_rates", force: true do |t|
    t.integer  "shipment_id"
    t.integer  "shipping_method_id"
    t.boolean  "selected",                                   default: false
    t.decimal  "cost",               precision: 8, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tax_rate_id"
  end

  add_index "spree_shipping_rates", ["shipment_id", "shipping_method_id"], name: "spree_shipping_rates_join_index", unique: true, using: :btree

  create_table "spree_sizing_guides", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "slug"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_sizing_guides", ["slug"], name: "index_spree_sizing_guides_on_slug", using: :btree

  create_table "spree_skrill_transactions", force: true do |t|
    t.string   "email"
    t.float    "amount"
    t.string   "currency"
    t.integer  "transaction_id"
    t.integer  "customer_id"
    t.string   "payment_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_state_changes", force: true do |t|
    t.string   "name"
    t.string   "previous_state"
    t.integer  "stateful_id"
    t.integer  "user_id"
    t.string   "stateful_type"
    t.string   "next_state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_states", force: true do |t|
    t.string   "name"
    t.string   "abbr"
    t.integer  "country_id"
    t.datetime "updated_at"
  end

  create_table "spree_stock_items", force: true do |t|
    t.integer  "stock_location_id"
    t.integer  "variant_id"
    t.integer  "count_on_hand",     default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "backorderable",     default: false
    t.datetime "deleted_at"
  end

  add_index "spree_stock_items", ["stock_location_id", "variant_id"], name: "stock_item_by_loc_and_var_id", using: :btree
  add_index "spree_stock_items", ["stock_location_id"], name: "index_spree_stock_items_on_stock_location_id", using: :btree

  create_table "spree_stock_locations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.integer  "state_id"
    t.string   "state_name"
    t.integer  "country_id"
    t.string   "zipcode"
    t.string   "phone"
    t.boolean  "active",                 default: true
    t.boolean  "backorderable_default",  default: false
    t.boolean  "propagate_all_variants", default: true
    t.string   "admin_name"
  end

  create_table "spree_stock_movements", force: true do |t|
    t.integer  "stock_item_id"
    t.integer  "quantity",        default: 0
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "originator_id"
    t.string   "originator_type"
  end

  add_index "spree_stock_movements", ["stock_item_id"], name: "index_spree_stock_movements_on_stock_item_id", using: :btree

  create_table "spree_stock_transfers", force: true do |t|
    t.string   "type"
    t.string   "reference"
    t.integer  "source_location_id"
    t.integer  "destination_location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "number"
  end

  add_index "spree_stock_transfers", ["destination_location_id"], name: "index_spree_stock_transfers_on_destination_location_id", using: :btree
  add_index "spree_stock_transfers", ["number"], name: "index_spree_stock_transfers_on_number", using: :btree
  add_index "spree_stock_transfers", ["source_location_id"], name: "index_spree_stock_transfers_on_source_location_id", using: :btree

  create_table "spree_store_payment_methods", force: true do |t|
    t.integer  "store_id"
    t.integer  "payment_method_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_store_shipping_methods", force: true do |t|
    t.integer  "store_id"
    t.integer  "shipping_method_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_store_shipping_methods", ["shipping_method_id"], name: "index_spree_store_shipping_methods_on_shipping_method_id", using: :btree
  add_index "spree_store_shipping_methods", ["store_id"], name: "index_spree_store_shipping_methods_on_store_id", using: :btree

  create_table "spree_stores", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.text     "domains"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "default",              default: false
    t.string   "email"
    t.string   "logo_file_name"
    t.string   "default_currency"
    t.string   "homepage_layout"
    t.string   "seo_title"
    t.string   "slug"
    t.integer  "parent_id"
    t.string   "create_your_own_link"
    t.integer  "page_id"
  end

  add_index "spree_stores", ["slug"], name: "index_spree_stores_on_slug", using: :btree

  create_table "spree_stores_homepage_slides", id: false, force: true do |t|
    t.integer "store_id"
    t.integer "homepage_slide_id"
  end

  add_index "spree_stores_homepage_slides", ["homepage_slide_id"], name: "index_spree_stores_homepage_slides_on_homepage_slide_id", using: :btree
  add_index "spree_stores_homepage_slides", ["store_id"], name: "index_spree_stores_homepage_slides_on_store_id", using: :btree

  create_table "spree_stores_stylesheets", id: false, force: true do |t|
    t.integer "stylesheet_id"
    t.integer "store_id"
  end

  create_table "spree_stylesheets", force: true do |t|
    t.string   "name"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.string   "banner_bg"
    t.string   "header_1_background_color"
    t.string   "header_1_color"
    t.string   "header_2_background_color"
    t.string   "header_2_color"
    t.string   "header_2_link_color"
    t.string   "product_background_color"
    t.string   "product_price_label_background_color"
    t.string   "product_price_label_color"
    t.string   "product_options_background_color"
    t.string   "product_options_option_background_color"
    t.string   "product_options_option_color"
    t.string   "product_options_option_inactive_background_color"
    t.string   "product_options_option_inactive_color"
    t.string   "leftnav_background_color"
    t.string   "leftnav_color_1"
    t.string   "leftnav_color_2"
    t.string   "leftnav_color_3"
    t.string   "layout_color_1"
    t.string   "layout_color_2"
    t.string   "layout_color_3"
    t.string   "layout_links_color"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hide_banner_text",                                 default: false
  end

  create_table "spree_tax_categories", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "is_default",  default: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_tax_rates", force: true do |t|
    t.decimal  "amount",             precision: 8, scale: 5
    t.integer  "zone_id"
    t.integer  "tax_category_id"
    t.boolean  "included_in_price",                          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "show_rate_in_label",                         default: true
    t.datetime "deleted_at"
  end

  create_table "spree_taxonomies", force: true do |t|
    t.string   "name",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",   default: 0
  end

  create_table "spree_taxonomies_stores", id: false, force: true do |t|
    t.integer "taxonomy_id"
    t.integer "store_id"
  end

  add_index "spree_taxonomies_stores", ["store_id"], name: "index_spree_taxonomies_stores_on_store_id", using: :btree
  add_index "spree_taxonomies_stores", ["taxonomy_id"], name: "index_spree_taxonomies_stores_on_taxonomy_id", using: :btree

  create_table "spree_taxons", force: true do |t|
    t.integer  "parent_id"
    t.integer  "position",          default: 0
    t.string   "name",                          null: false
    t.string   "permalink"
    t.integer  "taxonomy_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "meta_title"
    t.string   "meta_description"
    t.string   "meta_keywords"
    t.integer  "depth"
  end

  add_index "spree_taxons", ["parent_id"], name: "index_taxons_on_parent_id", using: :btree
  add_index "spree_taxons", ["permalink"], name: "index_taxons_on_permalink", using: :btree
  add_index "spree_taxons", ["taxonomy_id"], name: "index_taxons_on_taxonomy_id", using: :btree

  create_table "spree_tokenized_permissions", force: true do |t|
    t.integer  "permissable_id"
    t.string   "permissable_type"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_tokenized_permissions", ["permissable_id", "permissable_type"], name: "index_tokenized_name_and_type", using: :btree

  create_table "spree_trackers", force: true do |t|
    t.string   "environment"
    t.string   "analytics_id"
    t.boolean  "active",       default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id"
  end

  create_table "spree_twitter_hashtags", force: true do |t|
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_twitter_hashtags_spree_twitter_tweets", id: false, force: true do |t|
    t.integer "spree_twitter_hashtag_id", null: false
    t.integer "spree_twitter_tweet_id",   null: false
  end

  add_index "spree_twitter_hashtags_spree_twitter_tweets", ["spree_twitter_hashtag_id", "spree_twitter_tweet_id"], name: "by_hashtags_tweets", using: :btree
  add_index "spree_twitter_hashtags_spree_twitter_tweets", ["spree_twitter_tweet_id", "spree_twitter_hashtag_id"], name: "by_tweets_hashtags", using: :btree

  create_table "spree_twitter_tweets", force: true do |t|
    t.string   "in_reply_to_screen_name"
    t.integer  "in_reply_to_status_id"
    t.integer  "in_reply_to_user_id"
    t.string   "lang"
    t.integer  "retweet_count"
    t.text     "source"
    t.text     "attrs"
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tweet_id",                limit: 8
  end

  add_index "spree_twitter_tweets", ["tweet_id"], name: "index_spree_twitter_tweets_on_tweet_id", using: :btree

  create_table "spree_updates", force: true do |t|
    t.integer  "updatable_id"
    t.string   "updatable_type"
    t.text     "info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_users", force: true do |t|
    t.string   "encrypted_password",     limit: 128
    t.string   "password_salt",          limit: 128
    t.string   "email"
    t.string   "remember_token"
    t.string   "persistence_token"
    t.string   "reset_password_token"
    t.string   "perishable_token"
    t.integer  "sign_in_count",                      default: 0, null: false
    t.integer  "failed_attempts",                    default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "login"
    t.integer  "ship_address_id"
    t.integer  "bill_address_id"
    t.string   "authentication_token"
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "spree_api_key",          limit: 48
    t.datetime "remember_created_at"
    t.string   "vhx_customer_id"
  end

  add_index "spree_users", ["email"], name: "email_idx_unique", unique: true, using: :btree
  add_index "spree_users", ["spree_api_key"], name: "index_spree_users_on_spree_api_key", using: :btree

  create_table "spree_variants", force: true do |t|
    t.string   "sku",                                     default: "",    null: false
    t.decimal  "weight",          precision: 8, scale: 2, default: 0.0
    t.decimal  "height",          precision: 8, scale: 2
    t.decimal  "width",           precision: 8, scale: 2
    t.decimal  "depth",           precision: 8, scale: 2
    t.datetime "deleted_at"
    t.boolean  "is_master",                               default: false
    t.integer  "product_id"
    t.decimal  "cost_price",      precision: 8, scale: 2
    t.string   "cost_currency"
    t.integer  "position"
    t.boolean  "track_inventory",                         default: true
    t.integer  "tax_category_id"
    t.datetime "updated_at"
    t.string   "vhx_product_id"
  end

  add_index "spree_variants", ["product_id"], name: "index_spree_variants_on_product_id", using: :btree
  add_index "spree_variants", ["sku"], name: "index_spree_variants_on_sku", using: :btree
  add_index "spree_variants", ["tax_category_id"], name: "index_spree_variants_on_tax_category_id", using: :btree

  create_table "spree_wished_products", force: true do |t|
    t.integer  "variant_id"
    t.integer  "wishlist_id"
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_wishlists", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "access_hash"
    t.boolean  "is_private",  default: true,  null: false
    t.boolean  "is_default",  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_wishlists", ["user_id", "is_default"], name: "index_spree_wishlists_on_user_id_and_is_default", using: :btree
  add_index "spree_wishlists", ["user_id"], name: "index_spree_wishlists_on_user_id", using: :btree

  create_table "spree_zone_members", force: true do |t|
    t.integer  "zoneable_id"
    t.string   "zoneable_type"
    t.integer  "zone_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_zones", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "default_tax",        default: false
    t.integer  "zone_members_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
