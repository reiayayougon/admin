class AddEyeCatchInfoToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :eyecatch_align, :integer, default: 0, null: false
    add_column :articles, :eyecatch_width, :integer
  end
end
