CREATE TABLE "spree_addresses" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "firstname" varchar(255), "lastname" varchar(255), "address1" varchar(255), "address2" varchar(255), "city" varchar(255), "zipcode" varchar(255), "phone" varchar(255), "state_name" varchar(255), "alternative_phone" varchar(255), "company" varchar(255), "state_id" integer, "country_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_addresses_on_firstname" ON "spree_addresses" ("firstname");
CREATE INDEX "index_addresses_on_lastname" ON "spree_addresses" ("lastname");
CREATE TABLE "spree_adjustments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "source_id" integer, "source_type" varchar(255), "adjustable_id" integer, "adjustable_type" varchar(255), "amount" decimal(10,2), "label" varchar(255), "mandatory" boolean, "eligible" boolean DEFAULT 't', "created_at" datetime, "updated_at" datetime, "state" varchar(255), "order_id" integer, "included" boolean DEFAULT 'f');
CREATE INDEX "index_adjustments_on_order_id" ON "spree_adjustments" ("adjustable_id");
CREATE INDEX "index_spree_adjustments_on_source_type_and_source_id" ON "spree_adjustments" ("source_type", "source_id");
CREATE TABLE "spree_amazon_fps_checkouts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "transaction_id" varchar(255), "status" varchar(255), "created_at" datetime, "updated_at" datetime, "customer_name" varchar(255), "refund_transaction_id" varchar(255), "refunded_at" datetime, "payment_method_id" integer);
CREATE TABLE "spree_api_settings" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "type" varchar(255), "homepage" varchar(255), "api_endpoint" varchar(255), "auth_email" varchar(255), "auth_token" varchar(255));
CREATE UNIQUE INDEX "index_spree_api_settings_on_type" ON "spree_api_settings" ("type");
CREATE TABLE "spree_assets" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "viewable_id" integer, "viewable_type" varchar(255), "attachment_width" integer, "attachment_height" integer, "attachment_file_size" integer, "position" integer, "attachment_content_type" varchar(255), "attachment_file_name" varchar(255), "type" varchar(75), "attachment_updated_at" datetime, "alt" text, "option_value_id" integer, "thumbnail" boolean);
CREATE INDEX "index_spree_assets_on_option_value_id" ON "spree_assets" ("option_value_id");
CREATE INDEX "index_spree_assets_on_thumbnail" ON "spree_assets" ("thumbnail");
CREATE INDEX "index_assets_on_viewable_id" ON "spree_assets" ("viewable_id");
CREATE INDEX "index_assets_on_viewable_type_and_type" ON "spree_assets" ("viewable_type", "type");
CREATE TABLE "spree_calculators" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "type" varchar(255), "calculable_id" integer, "calculable_type" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_spree_calculators_on_calculable_id_and_calculable_type" ON "spree_calculators" ("calculable_id", "calculable_type");
CREATE INDEX "index_spree_calculators_on_id_and_type" ON "spree_calculators" ("id", "type");
CREATE TABLE "spree_commission_agents" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "product_id" integer, "user_id" integer, "calculator_type" varchar(255), "rate" decimal(4,2), "max" decimal(4,2), "min" decimal(4,2), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "spree_commission_payments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "amount" decimal(10,2), "bring_current_at" date, "user_id" integer, "payment_method" varchar(255), "transaction_id" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_spree_commission_payments_on_user_id" ON "spree_commission_payments" ("user_id");
CREATE TABLE "spree_commissions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "amount" decimal(10,2), "commission_agent_id" integer, "line_item_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "spree_configurations" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "type" varchar(50), "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_spree_configurations_on_name_and_type" ON "spree_configurations" ("name", "type");
CREATE TABLE "spree_countries" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "iso_name" varchar(255), "iso" varchar(255), "iso3" varchar(255), "name" varchar(255), "numcode" integer, "states_required" boolean DEFAULT 'f', "updated_at" datetime);
CREATE TABLE "spree_credit_cards" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "month" varchar(255), "year" varchar(255), "cc_type" varchar(255), "last_digits" varchar(255), "first_name" varchar(255), "last_name" varchar(255), "address_id" integer, "gateway_customer_profile_id" varchar(255), "gateway_payment_profile_id" varchar(255), "created_at" datetime, "updated_at" datetime, "name" varchar(255), "user_id" integer, "payment_method_id" integer);
CREATE INDEX "index_spree_credit_cards_on_payment_method_id" ON "spree_credit_cards" ("payment_method_id");
CREATE INDEX "index_spree_credit_cards_on_user_id" ON "spree_credit_cards" ("user_id");
CREATE TABLE "spree_digital_links" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "digital_id" integer, "line_item_id" integer, "secret" varchar(255), "access_counter" integer, "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_spree_digital_links_on_digital_id" ON "spree_digital_links" ("digital_id");
CREATE INDEX "index_spree_digital_links_on_line_item_id" ON "spree_digital_links" ("line_item_id");
CREATE INDEX "index_spree_digital_links_on_secret" ON "spree_digital_links" ("secret");
CREATE TABLE "spree_digitals" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "variant_id" integer, "attachment_file_name" varchar(255), "attachment_content_type" varchar(255), "attachment_file_size" integer, "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_spree_digitals_on_variant_id" ON "spree_digitals" ("variant_id");
CREATE TABLE "spree_gateways" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "type" varchar(255), "name" varchar(255), "description" text, "active" boolean DEFAULT 't', "environment" varchar(255) DEFAULT 'development', "server" varchar(255) DEFAULT 'test', "test_mode" boolean DEFAULT 't', "created_at" datetime, "updated_at" datetime);
CREATE TABLE "spree_google_products" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "google_product_category" varchar(255), "condition" varchar(255), "adult" boolean, "automatically_update" boolean, "variant_id" integer, "product_id" varchar(255), "last_insertion_date" datetime, "last_insertion_errors" text, "last_insertion_warnings" text, "created_at" datetime, "updated_at" datetime, "age_group" varchar(255), "size_type" varchar(255), "product_type" varchar(255));
CREATE INDEX "index_spree_google_products_on_variant_id" ON "spree_google_products" ("variant_id");
CREATE TABLE "spree_google_shopping_settings" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "merchant_id" varchar(255), "oauth2_client_id" varchar(255), "oauth2_client_secret" varchar(255), "current_access_token" varchar(255), "current_refresh_token" varchar(255), "current_expiration_date" datetime, "use_google_shopping" boolean, "created_at" datetime, "updated_at" datetime, "google_api_application_name" varchar(255), "current_host" varchar(255));
CREATE TABLE "spree_google_trusted_store_settings" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "account_id" varchar(255), "default_locale" varchar(255), "last_shipment_upload" datetime, "last_cancellation_upload" datetime);
CREATE TABLE "spree_homepage_products" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "product_id" integer, "homepage_id" integer, "position" integer, "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_spree_homepage_products_on_homepage_id" ON "spree_homepage_products" ("homepage_id");
CREATE INDEX "index_spree_homepage_products_on_product_id" ON "spree_homepage_products" ("product_id");
CREATE TABLE "spree_homepage_slides" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "description" varchar(255), "label" varchar(255), "text" varchar(255), "image_file_name" varchar(255), "image_content_type" varchar(255), "image_file_size" integer, "image_updated_at" datetime, "active" boolean);
CREATE INDEX "index_spree_homepage_slides_on_name" ON "spree_homepage_slides" ("name");
CREATE TABLE "spree_homepages" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "store_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_spree_homepages_on_store_id" ON "spree_homepages" ("store_id");
CREATE TABLE "spree_inventory_units" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "state" varchar(255), "variant_id" integer, "order_id" integer, "shipment_id" integer, "return_authorization_id" integer, "created_at" datetime, "updated_at" datetime, "pending" boolean DEFAULT 't', "line_item_id" integer);
CREATE INDEX "index_spree_inventory_units_on_line_item_id" ON "spree_inventory_units" ("line_item_id");
CREATE INDEX "index_inventory_units_on_order_id" ON "spree_inventory_units" ("order_id");
CREATE INDEX "index_inventory_units_on_shipment_id" ON "spree_inventory_units" ("shipment_id");
CREATE INDEX "index_inventory_units_on_variant_id" ON "spree_inventory_units" ("variant_id");
CREATE TABLE "spree_line_items" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "variant_id" integer, "order_id" integer, "quantity" integer NOT NULL, "price" decimal(8,2) NOT NULL, "created_at" datetime, "updated_at" datetime, "currency" varchar(255), "cost_price" decimal(8,2), "tax_category_id" integer, "adjustment_total" decimal(10,2) DEFAULT 0.0, "additional_tax_total" decimal(10,2) DEFAULT 0.0, "promo_total" decimal(10,2) DEFAULT 0.0, "included_tax_total" decimal(10,2) DEFAULT 0.0 NOT NULL, "pre_tax_amount" decimal(8,2), "store_id" integer);
CREATE INDEX "index_spree_line_items_on_order_id" ON "spree_line_items" ("order_id");
CREATE INDEX "index_spree_line_items_on_variant_id" ON "spree_line_items" ("variant_id");
CREATE TABLE "spree_log_entries" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "source_id" integer, "source_type" varchar(255), "details" text, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "spree_mockbot_publisher_steps" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "publisher_id" integer);
CREATE TABLE "spree_mockbot_publishers" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "idea_sku" varchar(255), "current_step" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "spree_option_types" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(100), "presentation" varchar(100), "position" integer DEFAULT 0 NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "spree_option_types_prototypes" ("prototype_id" integer, "option_type_id" integer);
CREATE TABLE "spree_option_values" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "position" integer, "name" varchar(255), "presentation" varchar(255), "option_type_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_spree_option_values_on_option_type_id" ON "spree_option_values" ("option_type_id");
CREATE TABLE "spree_option_values_variants" ("variant_id" integer, "option_value_id" integer);
CREATE INDEX "index_option_values_variants_on_variant_id_and_option_value_id" ON "spree_option_values_variants" ("variant_id", "option_value_id");
CREATE INDEX "index_spree_option_values_variants_on_variant_id" ON "spree_option_values_variants" ("variant_id");
CREATE TABLE "spree_orders" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "number" varchar(32), "item_total" decimal(10,2) DEFAULT 0.0 NOT NULL, "total" decimal(10,2) DEFAULT 0.0 NOT NULL, "state" varchar(255), "adjustment_total" decimal(10,2) DEFAULT 0.0 NOT NULL, "user_id" integer, "completed_at" datetime, "bill_address_id" integer, "ship_address_id" integer, "payment_total" decimal(10,2) DEFAULT 0.0, "shipping_method_id" integer, "shipment_state" varchar(255), "payment_state" varchar(255), "email" varchar(255), "special_instructions" text, "created_at" datetime, "updated_at" datetime, "currency" varchar(255), "last_ip_address" varchar(255), "created_by_id" integer, "shipment_total" decimal(10,2) DEFAULT 0.0 NOT NULL, "additional_tax_total" decimal(10,2) DEFAULT 0.0, "promo_total" decimal(10,2) DEFAULT 0.0, "channel" varchar(255) DEFAULT 'spree', "included_tax_total" decimal(10,2) DEFAULT 0.0 NOT NULL, "item_count" integer DEFAULT 0, "approver_id" integer, "approved_at" datetime, "confirmation_delivered" boolean DEFAULT 'f', "considered_risky" boolean DEFAULT 'f', "store_id" integer, "export_state" varchar(255), "dont_split_packages_on_backorder" boolean DEFAULT 'f');
CREATE INDEX "index_spree_orders_on_completed_at" ON "spree_orders" ("completed_at");
CREATE INDEX "index_spree_orders_on_number" ON "spree_orders" ("number");
CREATE INDEX "index_spree_orders_on_user_id_and_created_by_id" ON "spree_orders" ("user_id", "created_by_id");
CREATE INDEX "index_spree_orders_on_user_id" ON "spree_orders" ("user_id");
CREATE TABLE "spree_orders_promotions" ("order_id" integer, "promotion_id" integer);
CREATE TABLE "spree_pages" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "body" text, "slug" varchar(255), "created_at" datetime, "updated_at" datetime, "show_in_header" boolean DEFAULT 'f' NOT NULL, "show_in_footer" boolean DEFAULT 'f' NOT NULL, "foreign_link" varchar(255), "position" integer DEFAULT 1 NOT NULL, "visible" boolean DEFAULT 't', "meta_keywords" varchar(255), "meta_description" varchar(255), "layout" varchar(255), "show_in_sidebar" boolean DEFAULT 'f' NOT NULL, "meta_title" varchar(255), "render_layout_as_partial" boolean DEFAULT 'f');
CREATE INDEX "index_spree_pages_on_slug" ON "spree_pages" ("slug");
CREATE TABLE "spree_payment_capture_events" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "amount" decimal(10,2) DEFAULT 0.0, "payment_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_spree_payment_capture_events_on_payment_id" ON "spree_payment_capture_events" ("payment_id");
CREATE TABLE "spree_payment_methods" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "type" varchar(255), "name" varchar(255), "description" text, "active" boolean DEFAULT 't', "environment" varchar(255) DEFAULT 'development', "deleted_at" datetime, "created_at" datetime, "updated_at" datetime, "display_on" varchar(255), "auto_capture" boolean);
CREATE INDEX "index_spree_payment_methods_on_id_and_type" ON "spree_payment_methods" ("id", "type");
CREATE TABLE "spree_payments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "amount" decimal(10,2) DEFAULT 0.0 NOT NULL, "order_id" integer, "source_id" integer, "source_type" varchar(255), "payment_method_id" integer, "state" varchar(255), "response_code" varchar(255), "avs_response" varchar(255), "created_at" datetime, "updated_at" datetime, "identifier" varchar(255), "cvv_response_code" varchar(255), "cvv_response_message" varchar(255));
CREATE INDEX "index_spree_payments_on_order_id" ON "spree_payments" ("order_id");
CREATE INDEX "index_spree_payments_on_payment_method_id" ON "spree_payments" ("payment_method_id");
CREATE TABLE "spree_paypal_express_checkouts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "token" varchar(255), "payer_id" varchar(255), "transaction_id" varchar(255), "state" varchar(255) DEFAULT 'complete', "refund_transaction_id" varchar(255), "refunded_at" datetime, "refund_type" varchar(255), "created_at" datetime);
CREATE INDEX "index_spree_paypal_express_checkouts_on_transaction_id" ON "spree_paypal_express_checkouts" ("transaction_id");
CREATE TABLE "spree_preferences" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "value" text, "key" varchar(255), "value_type" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE UNIQUE INDEX "index_spree_preferences_on_key" ON "spree_preferences" ("key");
CREATE TABLE "spree_prices" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "variant_id" integer NOT NULL, "amount" decimal(8,2), "currency" varchar(255), "deleted_at" datetime);
CREATE INDEX "index_spree_prices_on_variant_id_and_currency" ON "spree_prices" ("variant_id", "currency");
CREATE TABLE "spree_product_option_types" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "position" integer, "product_id" integer, "option_type_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "spree_product_packages" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "product_id" integer NOT NULL, "length" integer DEFAULT 0 NOT NULL, "width" integer DEFAULT 0 NOT NULL, "height" integer DEFAULT 0 NOT NULL, "weight" integer DEFAULT 0 NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "spree_product_properties" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "value" varchar(255), "product_id" integer, "property_id" integer, "created_at" datetime, "updated_at" datetime, "position" integer DEFAULT 0);
CREATE INDEX "index_product_properties_on_product_id" ON "spree_product_properties" ("product_id");
CREATE TABLE "spree_products" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255) DEFAULT '' NOT NULL, "description" text, "available_on" datetime, "deleted_at" datetime, "slug" varchar(255), "meta_description" text, "meta_keywords" varchar(255), "tax_category_id" integer, "shipping_category_id" integer, "created_at" datetime, "updated_at" datetime, "layout" varchar(255) DEFAULT 'default', "digital_preview" text, "hashtag" varchar(255), "backorder_details" text);
CREATE INDEX "index_spree_products_on_available_on" ON "spree_products" ("available_on");
CREATE INDEX "index_spree_products_on_deleted_at" ON "spree_products" ("deleted_at");
CREATE INDEX "index_spree_products_on_layout" ON "spree_products" ("layout");
CREATE INDEX "index_spree_products_on_name" ON "spree_products" ("name");
CREATE INDEX "index_spree_products_on_slug" ON "spree_products" ("slug");
CREATE UNIQUE INDEX "permalink_idx_unique" ON "spree_products" ("slug");
CREATE TABLE "spree_products_promotion_rules" ("product_id" integer, "promotion_rule_id" integer);
CREATE INDEX "index_products_promotion_rules_on_product_id" ON "spree_products_promotion_rules" ("product_id");
CREATE INDEX "index_products_promotion_rules_on_promotion_rule_id" ON "spree_products_promotion_rules" ("promotion_rule_id");
CREATE TABLE "spree_products_stores" ("product_id" integer, "store_id" integer);
CREATE INDEX "index_spree_products_stores_on_product_id" ON "spree_products_stores" ("product_id");
CREATE INDEX "index_spree_products_stores_on_store_id" ON "spree_products_stores" ("store_id");
CREATE TABLE "spree_products_taxons" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "product_id" integer, "taxon_id" integer, "position" integer);
CREATE INDEX "index_spree_products_taxons_on_product_id" ON "spree_products_taxons" ("product_id");
CREATE INDEX "index_spree_products_taxons_on_taxon_id" ON "spree_products_taxons" ("taxon_id");
CREATE TABLE "spree_promotion_action_line_items" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "promotion_action_id" integer, "variant_id" integer, "quantity" integer DEFAULT 1);
CREATE TABLE "spree_promotion_actions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "promotion_id" integer, "position" integer, "type" varchar(255), "deleted_at" datetime);
CREATE INDEX "index_spree_promotion_actions_on_deleted_at" ON "spree_promotion_actions" ("deleted_at");
CREATE INDEX "index_spree_promotion_actions_on_id_and_type" ON "spree_promotion_actions" ("id", "type");
CREATE INDEX "index_spree_promotion_actions_on_promotion_id" ON "spree_promotion_actions" ("promotion_id");
CREATE TABLE "spree_promotion_rules" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "promotion_id" integer, "user_id" integer, "product_group_id" integer, "type" varchar(255), "created_at" datetime, "updated_at" datetime, "code" varchar(255));
CREATE INDEX "index_promotion_rules_on_product_group_id" ON "spree_promotion_rules" ("product_group_id");
CREATE INDEX "index_promotion_rules_on_user_id" ON "spree_promotion_rules" ("user_id");
CREATE TABLE "spree_promotion_rules_stores" ("promotion_rule_id" integer, "store_id" integer);
CREATE TABLE "spree_promotion_rules_users" ("user_id" integer, "promotion_rule_id" integer);
CREATE INDEX "index_promotion_rules_users_on_promotion_rule_id" ON "spree_promotion_rules_users" ("promotion_rule_id");
CREATE INDEX "index_promotion_rules_users_on_user_id" ON "spree_promotion_rules_users" ("user_id");
CREATE TABLE "spree_promotions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "description" varchar(255), "expires_at" datetime, "starts_at" datetime, "name" varchar(255), "type" varchar(255), "usage_limit" integer, "match_policy" varchar(255) DEFAULT 'all', "code" varchar(255), "advertise" boolean DEFAULT 'f', "path" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_spree_promotions_on_id_and_type" ON "spree_promotions" ("id", "type");
CREATE TABLE "spree_properties" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "presentation" varchar(255) NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "spree_properties_prototypes" ("prototype_id" integer, "property_id" integer);
CREATE TABLE "spree_prototypes" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "spree_return_authorizations" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "number" varchar(255), "state" varchar(255), "amount" decimal(10,2) DEFAULT 0.0 NOT NULL, "order_id" integer, "reason" text, "created_at" datetime, "updated_at" datetime, "stock_location_id" integer);
CREATE TABLE "spree_roles" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255));
CREATE TABLE "spree_roles_users" ("role_id" integer, "user_id" integer);
CREATE INDEX "index_spree_roles_users_on_role_id" ON "spree_roles_users" ("role_id");
CREATE INDEX "index_spree_roles_users_on_user_id" ON "spree_roles_users" ("user_id");
CREATE TABLE "spree_shipments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "tracking" varchar(255), "number" varchar(255), "cost" decimal(10,2) DEFAULT 0.0, "shipped_at" datetime, "order_id" integer, "address_id" integer, "state" varchar(255), "created_at" datetime, "updated_at" datetime, "stock_location_id" integer, "adjustment_total" decimal(10,2) DEFAULT 0.0, "additional_tax_total" decimal(10,2) DEFAULT 0.0, "promo_total" decimal(10,2) DEFAULT 0.0, "included_tax_total" decimal(10,2) DEFAULT 0.0 NOT NULL, "pre_tax_amount" decimal(8,2));
CREATE INDEX "index_shipments_on_number" ON "spree_shipments" ("number");
CREATE INDEX "index_spree_shipments_on_order_id" ON "spree_shipments" ("order_id");
CREATE INDEX "index_spree_shipments_on_stock_location_id" ON "spree_shipments" ("stock_location_id");
CREATE TABLE "spree_shipping_categories" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "spree_shipping_method_categories" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "shipping_method_id" integer NOT NULL, "shipping_category_id" integer NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE UNIQUE INDEX "unique_spree_shipping_method_categories" ON "spree_shipping_method_categories" ("shipping_category_id", "shipping_method_id");
CREATE INDEX "index_spree_shipping_method_categories_on_shipping_method_id" ON "spree_shipping_method_categories" ("shipping_method_id");
CREATE TABLE "spree_shipping_methods" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "display_on" varchar(255), "deleted_at" datetime, "created_at" datetime, "updated_at" datetime, "tracking_url" varchar(255), "admin_name" varchar(255), "tax_category_id" integer);
CREATE TABLE "spree_shipping_methods_zones" ("shipping_method_id" integer, "zone_id" integer);
CREATE TABLE "spree_shipping_rates" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "shipment_id" integer, "shipping_method_id" integer, "selected" boolean DEFAULT 'f', "cost" decimal(8,2) DEFAULT 0.0, "created_at" datetime, "updated_at" datetime, "tax_rate_id" integer);
CREATE UNIQUE INDEX "spree_shipping_rates_join_index" ON "spree_shipping_rates" ("shipment_id", "shipping_method_id");
CREATE TABLE "spree_sizing_guides" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "description" text, "slug" varchar(255), "deleted_at" datetime, "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_spree_sizing_guides_on_slug" ON "spree_sizing_guides" ("slug");
CREATE TABLE "spree_skrill_transactions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar(255), "amount" float, "currency" varchar(255), "transaction_id" integer, "customer_id" integer, "payment_type" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "spree_state_changes" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "previous_state" varchar(255), "stateful_id" integer, "user_id" integer, "stateful_type" varchar(255), "next_state" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "spree_states" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "abbr" varchar(255), "country_id" integer, "updated_at" datetime);
CREATE TABLE "spree_stock_items" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "stock_location_id" integer, "variant_id" integer, "count_on_hand" integer DEFAULT 0 NOT NULL, "created_at" datetime, "updated_at" datetime, "backorderable" boolean DEFAULT 'f', "deleted_at" datetime);
CREATE INDEX "stock_item_by_loc_and_var_id" ON "spree_stock_items" ("stock_location_id", "variant_id");
CREATE INDEX "index_spree_stock_items_on_stock_location_id" ON "spree_stock_items" ("stock_location_id");
CREATE TABLE "spree_stock_locations" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "created_at" datetime, "updated_at" datetime, "address1" varchar(255), "address2" varchar(255), "city" varchar(255), "state_id" integer, "state_name" varchar(255), "country_id" integer, "zipcode" varchar(255), "phone" varchar(255), "active" boolean DEFAULT 't', "backorderable_default" boolean DEFAULT 'f', "propagate_all_variants" boolean DEFAULT 't', "admin_name" varchar(255));
CREATE TABLE "spree_stock_movements" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "stock_item_id" integer, "quantity" integer DEFAULT 0, "action" varchar(255), "created_at" datetime, "updated_at" datetime, "originator_id" integer, "originator_type" varchar(255));
CREATE INDEX "index_spree_stock_movements_on_stock_item_id" ON "spree_stock_movements" ("stock_item_id");
CREATE TABLE "spree_stock_transfers" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "type" varchar(255), "reference" varchar(255), "source_location_id" integer, "destination_location_id" integer, "created_at" datetime, "updated_at" datetime, "number" varchar(255));
CREATE INDEX "index_spree_stock_transfers_on_destination_location_id" ON "spree_stock_transfers" ("destination_location_id");
CREATE INDEX "index_spree_stock_transfers_on_number" ON "spree_stock_transfers" ("number");
CREATE INDEX "index_spree_stock_transfers_on_source_location_id" ON "spree_stock_transfers" ("source_location_id");
CREATE TABLE "spree_store_payment_methods" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "store_id" integer, "payment_method_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "spree_store_shipping_methods" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "store_id" integer, "shipping_method_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_spree_store_shipping_methods_on_shipping_method_id" ON "spree_store_shipping_methods" ("shipping_method_id");
CREATE INDEX "index_spree_store_shipping_methods_on_store_id" ON "spree_store_shipping_methods" ("store_id");
CREATE TABLE "spree_stores" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "code" varchar(255), "domains" text, "created_at" datetime, "updated_at" datetime, "default" boolean DEFAULT 'f', "email" varchar(255), "logo_file_name" varchar(255), "default_currency" varchar(255), "homepage_layout" varchar(255), "seo_title" varchar(255), "slug" varchar(255), "parent_id" integer, "create_your_own_link" varchar(255), "page_id" integer);
CREATE INDEX "index_spree_stores_on_slug" ON "spree_stores" ("slug");
CREATE TABLE "spree_stores_homepage_slides" ("store_id" integer, "homepage_slide_id" integer);
CREATE INDEX "index_spree_stores_homepage_slides_on_homepage_slide_id" ON "spree_stores_homepage_slides" ("homepage_slide_id");
CREATE INDEX "index_spree_stores_homepage_slides_on_store_id" ON "spree_stores_homepage_slides" ("store_id");
CREATE TABLE "spree_stores_stylesheets" ("stylesheet_id" integer, "store_id" integer);
CREATE TABLE "spree_stylesheets" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "logo_file_name" varchar(255), "logo_content_type" varchar(255), "logo_file_size" integer, "logo_updated_at" datetime, "banner_file_name" varchar(255), "banner_content_type" varchar(255), "banner_file_size" integer, "banner_updated_at" datetime, "banner_bg" varchar(255), "header_1_background_color" varchar(255), "header_1_color" varchar(255), "header_2_background_color" varchar(255), "header_2_color" varchar(255), "header_2_link_color" varchar(255), "product_background_color" varchar(255), "product_price_label_background_color" varchar(255), "product_price_label_color" varchar(255), "product_options_background_color" varchar(255), "product_options_option_background_color" varchar(255), "product_options_option_color" varchar(255), "product_options_option_inactive_background_color" varchar(255), "product_options_option_inactive_color" varchar(255), "leftnav_background_color" varchar(255), "leftnav_color_1" varchar(255), "leftnav_color_2" varchar(255), "leftnav_color_3" varchar(255), "layout_color_1" varchar(255), "layout_color_2" varchar(255), "layout_color_3" varchar(255), "layout_links_color" varchar(255), "created_at" datetime, "updated_at" datetime, "hide_banner_text" boolean DEFAULT 'f');
CREATE TABLE "spree_tax_categories" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "description" varchar(255), "is_default" boolean DEFAULT 'f', "deleted_at" datetime, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "spree_tax_rates" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "amount" decimal(8,5), "zone_id" integer, "tax_category_id" integer, "included_in_price" boolean DEFAULT 'f', "created_at" datetime, "updated_at" datetime, "name" varchar(255), "show_rate_in_label" boolean DEFAULT 't', "deleted_at" datetime);
CREATE TABLE "spree_taxonomies" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255) NOT NULL, "created_at" datetime, "updated_at" datetime, "position" integer DEFAULT 0);
CREATE TABLE "spree_taxonomies_stores" ("taxonomy_id" integer, "store_id" integer);
CREATE INDEX "index_spree_taxonomies_stores_on_store_id" ON "spree_taxonomies_stores" ("store_id");
CREATE INDEX "index_spree_taxonomies_stores_on_taxonomy_id" ON "spree_taxonomies_stores" ("taxonomy_id");
CREATE TABLE "spree_taxons" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "parent_id" integer, "position" integer DEFAULT 0, "name" varchar(255) NOT NULL, "permalink" varchar(255), "taxonomy_id" integer, "lft" integer, "rgt" integer, "icon_file_name" varchar(255), "icon_content_type" varchar(255), "icon_file_size" integer, "icon_updated_at" datetime, "description" text, "created_at" datetime, "updated_at" datetime, "meta_title" varchar(255), "meta_description" varchar(255), "meta_keywords" varchar(255), "depth" integer);
CREATE INDEX "index_taxons_on_parent_id" ON "spree_taxons" ("parent_id");
CREATE INDEX "index_taxons_on_permalink" ON "spree_taxons" ("permalink");
CREATE INDEX "index_taxons_on_taxonomy_id" ON "spree_taxons" ("taxonomy_id");
CREATE TABLE "spree_tokenized_permissions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "permissable_id" integer, "permissable_type" varchar(255), "token" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_tokenized_name_and_type" ON "spree_tokenized_permissions" ("permissable_id", "permissable_type");
CREATE TABLE "spree_trackers" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "environment" varchar(255), "analytics_id" varchar(255), "active" boolean DEFAULT 't', "created_at" datetime, "updated_at" datetime, "store_id" integer);
CREATE TABLE "spree_twitter_hashtags" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "value" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "spree_twitter_hashtags_spree_twitter_tweets" ("spree_twitter_hashtag_id" integer NOT NULL, "spree_twitter_tweet_id" integer NOT NULL);
CREATE INDEX "by_hashtags_tweets" ON "spree_twitter_hashtags_spree_twitter_tweets" ("spree_twitter_hashtag_id", "spree_twitter_tweet_id");
CREATE INDEX "by_tweets_hashtags" ON "spree_twitter_hashtags_spree_twitter_tweets" ("spree_twitter_tweet_id", "spree_twitter_hashtag_id");
CREATE TABLE "spree_twitter_tweets" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "in_reply_to_screen_name" varchar(255), "in_reply_to_status_id" integer, "in_reply_to_user_id" integer, "lang" varchar(255), "retweet_count" integer, "source" text, "attrs" text, "url" text, "created_at" datetime, "updated_at" datetime, "tweet_id" integer(8));
CREATE INDEX "index_spree_twitter_tweets_on_tweet_id" ON "spree_twitter_tweets" ("tweet_id");
CREATE TABLE "spree_updates" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "updatable_id" integer, "updatable_type" varchar(255), "info" text, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "spree_users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "encrypted_password" varchar(128), "password_salt" varchar(128), "email" varchar(255), "remember_token" varchar(255), "persistence_token" varchar(255), "reset_password_token" varchar(255), "perishable_token" varchar(255), "sign_in_count" integer DEFAULT 0 NOT NULL, "failed_attempts" integer DEFAULT 0 NOT NULL, "last_request_at" datetime, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar(255), "last_sign_in_ip" varchar(255), "login" varchar(255), "ship_address_id" integer, "bill_address_id" integer, "authentication_token" varchar(255), "unlock_token" varchar(255), "locked_at" datetime, "reset_password_sent_at" datetime, "created_at" datetime, "updated_at" datetime, "spree_api_key" varchar(48), "remember_created_at" datetime);
CREATE UNIQUE INDEX "email_idx_unique" ON "spree_users" ("email");
CREATE INDEX "index_spree_users_on_spree_api_key" ON "spree_users" ("spree_api_key");
CREATE TABLE "spree_variants" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "sku" varchar(255) DEFAULT '' NOT NULL, "weight" decimal(8,2) DEFAULT 0.0, "height" decimal(8,2), "width" decimal(8,2), "depth" decimal(8,2), "deleted_at" datetime, "is_master" boolean DEFAULT 'f', "product_id" integer, "cost_price" decimal(8,2), "cost_currency" varchar(255), "position" integer, "track_inventory" boolean DEFAULT 't', "tax_category_id" integer, "updated_at" datetime);
CREATE INDEX "index_spree_variants_on_product_id" ON "spree_variants" ("product_id");
CREATE INDEX "index_spree_variants_on_sku" ON "spree_variants" ("sku");
CREATE INDEX "index_spree_variants_on_tax_category_id" ON "spree_variants" ("tax_category_id");
CREATE TABLE "spree_wished_products" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "variant_id" integer, "wishlist_id" integer, "remark" text, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "spree_wishlists" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "name" varchar(255), "access_hash" varchar(255), "is_private" boolean DEFAULT 't' NOT NULL, "is_default" boolean DEFAULT 'f' NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_spree_wishlists_on_user_id_and_is_default" ON "spree_wishlists" ("user_id", "is_default");
CREATE INDEX "index_spree_wishlists_on_user_id" ON "spree_wishlists" ("user_id");
CREATE TABLE "spree_zone_members" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "zoneable_id" integer, "zoneable_type" varchar(255), "zone_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "spree_zones" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "description" varchar(255), "default_tax" boolean DEFAULT 'f', "zone_members_count" integer DEFAULT 0, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20140312210641');

INSERT INTO schema_migrations (version) VALUES ('20140312210642');

INSERT INTO schema_migrations (version) VALUES ('20140312210643');

INSERT INTO schema_migrations (version) VALUES ('20140312210644');

INSERT INTO schema_migrations (version) VALUES ('20140312210645');

INSERT INTO schema_migrations (version) VALUES ('20140312210646');

INSERT INTO schema_migrations (version) VALUES ('20140312210647');

INSERT INTO schema_migrations (version) VALUES ('20140312210648');

INSERT INTO schema_migrations (version) VALUES ('20140312210649');

INSERT INTO schema_migrations (version) VALUES ('20140312210650');

INSERT INTO schema_migrations (version) VALUES ('20140312210651');

INSERT INTO schema_migrations (version) VALUES ('20140312210652');

INSERT INTO schema_migrations (version) VALUES ('20140312210653');

INSERT INTO schema_migrations (version) VALUES ('20140312210654');

INSERT INTO schema_migrations (version) VALUES ('20140312210655');

INSERT INTO schema_migrations (version) VALUES ('20140312210656');

INSERT INTO schema_migrations (version) VALUES ('20140312210657');

INSERT INTO schema_migrations (version) VALUES ('20140312210658');

INSERT INTO schema_migrations (version) VALUES ('20140312210659');

INSERT INTO schema_migrations (version) VALUES ('20140312210660');

INSERT INTO schema_migrations (version) VALUES ('20140312210661');

INSERT INTO schema_migrations (version) VALUES ('20140312210662');

INSERT INTO schema_migrations (version) VALUES ('20140312210663');

INSERT INTO schema_migrations (version) VALUES ('20140312210664');

INSERT INTO schema_migrations (version) VALUES ('20140312210665');

INSERT INTO schema_migrations (version) VALUES ('20140312210666');

INSERT INTO schema_migrations (version) VALUES ('20140312210667');

INSERT INTO schema_migrations (version) VALUES ('20140312210668');

INSERT INTO schema_migrations (version) VALUES ('20140312210669');

INSERT INTO schema_migrations (version) VALUES ('20140312210670');

INSERT INTO schema_migrations (version) VALUES ('20140312210671');

INSERT INTO schema_migrations (version) VALUES ('20140312210672');

INSERT INTO schema_migrations (version) VALUES ('20140312210673');

INSERT INTO schema_migrations (version) VALUES ('20140312210674');

INSERT INTO schema_migrations (version) VALUES ('20140312210675');

INSERT INTO schema_migrations (version) VALUES ('20140312210676');

INSERT INTO schema_migrations (version) VALUES ('20140312210677');

INSERT INTO schema_migrations (version) VALUES ('20140312210678');

INSERT INTO schema_migrations (version) VALUES ('20140312210679');

INSERT INTO schema_migrations (version) VALUES ('20140312210680');

INSERT INTO schema_migrations (version) VALUES ('20140312210681');

INSERT INTO schema_migrations (version) VALUES ('20140312210682');

INSERT INTO schema_migrations (version) VALUES ('20140312210683');

INSERT INTO schema_migrations (version) VALUES ('20140312210684');

INSERT INTO schema_migrations (version) VALUES ('20140312210685');

INSERT INTO schema_migrations (version) VALUES ('20140312210686');

INSERT INTO schema_migrations (version) VALUES ('20140312210687');

INSERT INTO schema_migrations (version) VALUES ('20140312210688');

INSERT INTO schema_migrations (version) VALUES ('20140312210689');

INSERT INTO schema_migrations (version) VALUES ('20140312210690');

INSERT INTO schema_migrations (version) VALUES ('20140312210691');

INSERT INTO schema_migrations (version) VALUES ('20140312210692');

INSERT INTO schema_migrations (version) VALUES ('20140312210693');

INSERT INTO schema_migrations (version) VALUES ('20140312210694');

INSERT INTO schema_migrations (version) VALUES ('20140312210695');

INSERT INTO schema_migrations (version) VALUES ('20140312210696');

INSERT INTO schema_migrations (version) VALUES ('20140312210697');

INSERT INTO schema_migrations (version) VALUES ('20140312210698');

INSERT INTO schema_migrations (version) VALUES ('20140312210699');

INSERT INTO schema_migrations (version) VALUES ('20140312210700');

INSERT INTO schema_migrations (version) VALUES ('20140312210701');

INSERT INTO schema_migrations (version) VALUES ('20140312210702');

INSERT INTO schema_migrations (version) VALUES ('20140312210703');

INSERT INTO schema_migrations (version) VALUES ('20140312210704');

INSERT INTO schema_migrations (version) VALUES ('20140312210705');

INSERT INTO schema_migrations (version) VALUES ('20140312210706');

INSERT INTO schema_migrations (version) VALUES ('20140312210707');

INSERT INTO schema_migrations (version) VALUES ('20140312210708');

INSERT INTO schema_migrations (version) VALUES ('20140312210709');

INSERT INTO schema_migrations (version) VALUES ('20140312210710');

INSERT INTO schema_migrations (version) VALUES ('20140312210711');

INSERT INTO schema_migrations (version) VALUES ('20140312210712');

INSERT INTO schema_migrations (version) VALUES ('20140312210713');

INSERT INTO schema_migrations (version) VALUES ('20140312210714');

INSERT INTO schema_migrations (version) VALUES ('20140312210715');

INSERT INTO schema_migrations (version) VALUES ('20140312210716');

INSERT INTO schema_migrations (version) VALUES ('20140312210717');

INSERT INTO schema_migrations (version) VALUES ('20140312210718');

INSERT INTO schema_migrations (version) VALUES ('20140312210719');

INSERT INTO schema_migrations (version) VALUES ('20140312210720');

INSERT INTO schema_migrations (version) VALUES ('20140312210721');

INSERT INTO schema_migrations (version) VALUES ('20140312210722');

INSERT INTO schema_migrations (version) VALUES ('20140312210723');

INSERT INTO schema_migrations (version) VALUES ('20140312210724');

INSERT INTO schema_migrations (version) VALUES ('20140312210725');

INSERT INTO schema_migrations (version) VALUES ('20140312210726');

INSERT INTO schema_migrations (version) VALUES ('20140312210727');

INSERT INTO schema_migrations (version) VALUES ('20140312210728');

INSERT INTO schema_migrations (version) VALUES ('20140312210729');

INSERT INTO schema_migrations (version) VALUES ('20140312210730');

INSERT INTO schema_migrations (version) VALUES ('20140312210731');

INSERT INTO schema_migrations (version) VALUES ('20140312210732');

INSERT INTO schema_migrations (version) VALUES ('20140312210733');

INSERT INTO schema_migrations (version) VALUES ('20140312210734');

INSERT INTO schema_migrations (version) VALUES ('20140312210735');

INSERT INTO schema_migrations (version) VALUES ('20140312210736');

INSERT INTO schema_migrations (version) VALUES ('20140312210737');

INSERT INTO schema_migrations (version) VALUES ('20140312210738');

INSERT INTO schema_migrations (version) VALUES ('20140312210739');

INSERT INTO schema_migrations (version) VALUES ('20140312210740');

INSERT INTO schema_migrations (version) VALUES ('20140312210741');

INSERT INTO schema_migrations (version) VALUES ('20140312210742');

INSERT INTO schema_migrations (version) VALUES ('20140312210743');

INSERT INTO schema_migrations (version) VALUES ('20140312210744');

INSERT INTO schema_migrations (version) VALUES ('20140312210745');

INSERT INTO schema_migrations (version) VALUES ('20140312210746');

INSERT INTO schema_migrations (version) VALUES ('20140312210747');

INSERT INTO schema_migrations (version) VALUES ('20140312210748');

INSERT INTO schema_migrations (version) VALUES ('20140312210749');

INSERT INTO schema_migrations (version) VALUES ('20140312210750');

INSERT INTO schema_migrations (version) VALUES ('20140312210751');

INSERT INTO schema_migrations (version) VALUES ('20140312210752');

INSERT INTO schema_migrations (version) VALUES ('20140312210753');

INSERT INTO schema_migrations (version) VALUES ('20140312210754');

INSERT INTO schema_migrations (version) VALUES ('20140312210755');

INSERT INTO schema_migrations (version) VALUES ('20140312210756');

INSERT INTO schema_migrations (version) VALUES ('20140312210757');

INSERT INTO schema_migrations (version) VALUES ('20140312210758');

INSERT INTO schema_migrations (version) VALUES ('20140312210759');

INSERT INTO schema_migrations (version) VALUES ('20140312210760');

INSERT INTO schema_migrations (version) VALUES ('20140312210761');

INSERT INTO schema_migrations (version) VALUES ('20140312210762');

INSERT INTO schema_migrations (version) VALUES ('20140312210763');

INSERT INTO schema_migrations (version) VALUES ('20140312210764');

INSERT INTO schema_migrations (version) VALUES ('20140312210765');

INSERT INTO schema_migrations (version) VALUES ('20140312210766');

INSERT INTO schema_migrations (version) VALUES ('20140312210767');

INSERT INTO schema_migrations (version) VALUES ('20140312210768');

INSERT INTO schema_migrations (version) VALUES ('20140312210769');

INSERT INTO schema_migrations (version) VALUES ('20140312210770');

INSERT INTO schema_migrations (version) VALUES ('20140312210771');

INSERT INTO schema_migrations (version) VALUES ('20140312210772');

INSERT INTO schema_migrations (version) VALUES ('20140312210773');

INSERT INTO schema_migrations (version) VALUES ('20140312210774');

INSERT INTO schema_migrations (version) VALUES ('20140312210775');

INSERT INTO schema_migrations (version) VALUES ('20140312210776');

INSERT INTO schema_migrations (version) VALUES ('20140312210777');

INSERT INTO schema_migrations (version) VALUES ('20140312210778');

INSERT INTO schema_migrations (version) VALUES ('20140312210779');

INSERT INTO schema_migrations (version) VALUES ('20140312210780');

INSERT INTO schema_migrations (version) VALUES ('20140312210781');

INSERT INTO schema_migrations (version) VALUES ('20140312210782');

INSERT INTO schema_migrations (version) VALUES ('20140312210783');

INSERT INTO schema_migrations (version) VALUES ('20140529011856');

INSERT INTO schema_migrations (version) VALUES ('20140529011857');

INSERT INTO schema_migrations (version) VALUES ('20140529011858');

INSERT INTO schema_migrations (version) VALUES ('20140529011859');

INSERT INTO schema_migrations (version) VALUES ('20140529011860');

INSERT INTO schema_migrations (version) VALUES ('20140529011861');

INSERT INTO schema_migrations (version) VALUES ('20140529011862');

INSERT INTO schema_migrations (version) VALUES ('20140529011863');

INSERT INTO schema_migrations (version) VALUES ('20140529011864');

INSERT INTO schema_migrations (version) VALUES ('20140529011865');

INSERT INTO schema_migrations (version) VALUES ('20140529011866');

INSERT INTO schema_migrations (version) VALUES ('20140529011867');

INSERT INTO schema_migrations (version) VALUES ('20140529011868');

INSERT INTO schema_migrations (version) VALUES ('20140529011869');

INSERT INTO schema_migrations (version) VALUES ('20140529011870');

INSERT INTO schema_migrations (version) VALUES ('20140530183433');

INSERT INTO schema_migrations (version) VALUES ('20140530183434');

INSERT INTO schema_migrations (version) VALUES ('20140530183435');

INSERT INTO schema_migrations (version) VALUES ('20140530183436');

INSERT INTO schema_migrations (version) VALUES ('20140530183437');

INSERT INTO schema_migrations (version) VALUES ('20140530183438');

INSERT INTO schema_migrations (version) VALUES ('20140530183439');

INSERT INTO schema_migrations (version) VALUES ('20140604205301');

INSERT INTO schema_migrations (version) VALUES ('20140828181639');

INSERT INTO schema_migrations (version) VALUES ('20140828181640');

INSERT INTO schema_migrations (version) VALUES ('20140828181641');

INSERT INTO schema_migrations (version) VALUES ('20140828181642');

INSERT INTO schema_migrations (version) VALUES ('20140828181643');

INSERT INTO schema_migrations (version) VALUES ('20140828200444');

INSERT INTO schema_migrations (version) VALUES ('20140904065823');

INSERT INTO schema_migrations (version) VALUES ('20140904065824');

INSERT INTO schema_migrations (version) VALUES ('20140904065825');

INSERT INTO schema_migrations (version) VALUES ('20140904065826');

INSERT INTO schema_migrations (version) VALUES ('20140907213205');

INSERT INTO schema_migrations (version) VALUES ('20140907213206');

INSERT INTO schema_migrations (version) VALUES ('20140907213207');

INSERT INTO schema_migrations (version) VALUES ('20140907213208');

INSERT INTO schema_migrations (version) VALUES ('20141003185550');

INSERT INTO schema_migrations (version) VALUES ('20141021184003');

INSERT INTO schema_migrations (version) VALUES ('20141024015030');

INSERT INTO schema_migrations (version) VALUES ('20141024185653');

INSERT INTO schema_migrations (version) VALUES ('20141024202630');

INSERT INTO schema_migrations (version) VALUES ('20141024202631');

INSERT INTO schema_migrations (version) VALUES ('20141027210540');

INSERT INTO schema_migrations (version) VALUES ('20141028151136');

INSERT INTO schema_migrations (version) VALUES ('20141031045024');

INSERT INTO schema_migrations (version) VALUES ('20141107191117');

INSERT INTO schema_migrations (version) VALUES ('20141107191118');

INSERT INTO schema_migrations (version) VALUES ('20141110210848');

INSERT INTO schema_migrations (version) VALUES ('20141125153928');

INSERT INTO schema_migrations (version) VALUES ('20141125153929');

INSERT INTO schema_migrations (version) VALUES ('20141125170450');

INSERT INTO schema_migrations (version) VALUES ('20141126165735');

INSERT INTO schema_migrations (version) VALUES ('20141126214402');

INSERT INTO schema_migrations (version) VALUES ('20141207013234');

INSERT INTO schema_migrations (version) VALUES ('20141207013235');

INSERT INTO schema_migrations (version) VALUES ('20141207013236');

INSERT INTO schema_migrations (version) VALUES ('20141207013237');

INSERT INTO schema_migrations (version) VALUES ('20141207013238');

INSERT INTO schema_migrations (version) VALUES ('20141207051401');

INSERT INTO schema_migrations (version) VALUES ('20141209191415');

INSERT INTO schema_migrations (version) VALUES ('20141209194252');

INSERT INTO schema_migrations (version) VALUES ('20141210194906');

INSERT INTO schema_migrations (version) VALUES ('20141213003038');

INSERT INTO schema_migrations (version) VALUES ('20141213003039');

INSERT INTO schema_migrations (version) VALUES ('20141213003040');

INSERT INTO schema_migrations (version) VALUES ('20141213184606');

INSERT INTO schema_migrations (version) VALUES ('20141215210405');

INSERT INTO schema_migrations (version) VALUES ('20141216204319');

INSERT INTO schema_migrations (version) VALUES ('20141216235731');

INSERT INTO schema_migrations (version) VALUES ('20150113203820');

INSERT INTO schema_migrations (version) VALUES ('20150113203821');

INSERT INTO schema_migrations (version) VALUES ('20150203023243');

INSERT INTO schema_migrations (version) VALUES ('20150319202535');

INSERT INTO schema_migrations (version) VALUES ('20150325164001');

INSERT INTO schema_migrations (version) VALUES ('20150404200107');

INSERT INTO schema_migrations (version) VALUES ('20151002145942');

INSERT INTO schema_migrations (version) VALUES ('20151203171457');

INSERT INTO schema_migrations (version) VALUES ('20151203171458');

INSERT INTO schema_migrations (version) VALUES ('20151203171459');

INSERT INTO schema_migrations (version) VALUES ('20151203171460');

INSERT INTO schema_migrations (version) VALUES ('20151203171461');

INSERT INTO schema_migrations (version) VALUES ('20151203171462');

INSERT INTO schema_migrations (version) VALUES ('20151203171463');

INSERT INTO schema_migrations (version) VALUES ('20151203171464');

INSERT INTO schema_migrations (version) VALUES ('20151203171465');

INSERT INTO schema_migrations (version) VALUES ('20151203171466');

INSERT INTO schema_migrations (version) VALUES ('20151204180251');

INSERT INTO schema_migrations (version) VALUES ('20151205193839');

INSERT INTO schema_migrations (version) VALUES ('20151209163150');

INSERT INTO schema_migrations (version) VALUES ('20151216220022');
