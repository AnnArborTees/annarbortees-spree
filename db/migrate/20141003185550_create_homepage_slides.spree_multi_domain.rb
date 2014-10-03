# This migration comes from spree_multi_domain (originally 20141003123456)
class CreateHomepageSlides < ActiveRecord::Migration
  def change
    create_table :spree_homepage_slides do |t|
      t.string :name
      t.string :description
      t.string :label
      t.string :text
      t.attachment :image
      t.boolean :active
    end

    create_table :spree_stores_homepage_slides, id: false do |t|
      t.references :store
      t.references :homepage_slide
    end

    add_index :spree_homepage_slides, :name
    add_index :spree_stores_homepage_slides, :store_id
    add_index :spree_stores_homepage_slides, :homepage_slide_id

  end
end
