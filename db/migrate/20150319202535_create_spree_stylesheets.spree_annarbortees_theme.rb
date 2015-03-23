# This migration comes from spree_annarbortees_theme (originally 20150319020429)
class CreateSpreeStylesheets < ActiveRecord::Migration
  def change
    create_table :spree_stylesheets do |t|
      t.string :name
      t.attachment :logo
      t.attachment :banner
      t.string :banner_bg
      t.string :header_1_background_color
      t.string :header_1_color
      t.string :header_2_background_color
      t.string :header_2_color
      t.string :header_2_link_color
      t.string :product_background_color
      t.string :product_price_label_background_color
      t.string :product_price_label_color
      t.string :product_options_background_color
      t.string :product_options_option_background_color
      t.string :product_options_option_color
      t.string :product_options_option_inactive_background_color
      t.string :product_options_option_inactive_color
      t.string :leftnav_background_color
      t.string :leftnav_color_1
      t.string :leftnav_color_2
      t.string :leftnav_color_3
      t.string :layout_color_1
      t.string :layout_color_2
      t.string :layout_color_3
      t.string :layout_links_color
      t.timestamps
    end

    create_table :spree_stores_stylesheets, id: false do |t|
      t.integer :stylesheet_id, index: true
      t.integer :store_id, index: true
    end


  end
end
