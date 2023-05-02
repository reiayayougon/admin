class CreateSites < ActiveRecord::Migration[5.2]
  def change
    create_table :sites do |t|
      t.string :name
      t.string :subtitle
      t.text :description
      t.timestamps
    end
  end
end
