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

require 'rails_helper'

RSpec.describe ArticleTag, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
end
