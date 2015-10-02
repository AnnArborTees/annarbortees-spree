# This migration comes from spree_annarbortees_theme (originally 20151002142755)
class AddHideHomepageText < ActiveRecord::Migration
  def change
    add_column :spree_stylesheets, :hide_banner_text, :boolean, default: false
  end
end
