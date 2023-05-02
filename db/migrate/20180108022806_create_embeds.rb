class CreateEmbeds < ActiveRecord::Migration[5.2]
  def change
    create_table :embeds do |t|
      t.integer :embed_type, default: 0, null: false
      t.string :identifier
      t.timestamps
    end
  end
end
