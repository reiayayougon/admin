class CreateMedia < ActiveRecord::Migration[5.2]
  def change
    create_table :media do |t|
      t.integer :media_type, default: 0, null: false
      t.string :name
      t.timestamps
    end
  end
end
