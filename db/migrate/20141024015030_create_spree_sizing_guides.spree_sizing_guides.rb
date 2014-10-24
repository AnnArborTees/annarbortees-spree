# This migration comes from spree_sizing_guides (originally 20141023204920)
class CreateSpreeSizingGuides < ActiveRecord::Migration
  def change
    create_table :spree_sizing_guides do |t|
      t.string :name
      t.text :description
      t.string :slug
      t.datetime :deleted_at
      t.timestamps
    end

    add_index :spree_sizing_guides, :slug

  end
end
