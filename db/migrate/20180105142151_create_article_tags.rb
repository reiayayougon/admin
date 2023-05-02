class CreateArticleTags < ActiveRecord::Migration[5.2]
  def change
    create_table :article_tags do |t|
      t.belongs_to :article
      t.belongs_to :tag
      t.timestamps
    end
  end
end
