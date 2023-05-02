# == Schema Information
#
# Table name: article_tags
#
#  id         :bigint           not null, primary key
#  article_id :bigint
#  tag_id     :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_article_tags_on_article_id  (article_id)
#  index_article_tags_on_tag_id      (tag_id)
#

class ArticleTag < ApplicationRecord
  belongs_to :article
  belongs_to :tag
end
