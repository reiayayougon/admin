class CreateTaxonomies < ActiveRecord::Migration[5.2]
  def change
    create_table :taxonomies do |t|
      t.string :type
      t.string :name
      t.string :slug
      t.text :description
      t.timestamps

      t.index :type
      t.index :slug
    end
  end
end
