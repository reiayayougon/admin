class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.belongs_to :category
      t.belongs_to :author
      t.string :uuid
      t.string :slug
      t.string :title
      t.text :description
      t.text :body
      t.integer :state, default: 0, null: false
      t.datetime :published_at
      t.timestamps
      t.datetime :deleted_at

      t.index :uuid
      t.index :slug
      t.index :published_at
      t.index :deleted_at
    end
  end
end
