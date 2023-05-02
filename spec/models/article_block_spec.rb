# == Schema Information
#
# Table name: article_blocks
#
#  id             :bigint           not null, primary key
#  article_id     :bigint
#  blockable_type :string(255)
#  blockable_id   :bigint
#  level          :integer          default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_article_blocks_on_article_id                       (article_id)
#  index_article_blocks_on_blockable_type_and_blockable_id  (blockable_type,blockable_id)
#  index_article_blocks_on_level                            (level)
#

require 'rails_helper'

RSpec.describe ArticleBlock, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
end
