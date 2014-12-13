# This migration comes from spree_annarbortees_twitter (originally 20141212051327)
class AddHashtagToProduct < ActiveRecord::Migration
  def change
    add_column :spree_products, :hashtag, :string
  end
end
