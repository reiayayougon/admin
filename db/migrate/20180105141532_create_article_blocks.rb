class CreateArticleBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :article_blocks do |t|
      t.belongs_to :article
      t.belongs_to :blockable, polymorphic: true
      t.integer :level, default: 0, null: false
      t.timestamps

      t.index :level
    end
  end
end
