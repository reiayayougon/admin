# == Schema Information
#
# Table name: embeds
#
#  id         :bigint           not null, primary key
#  embed_type :integer          default("youtube"), not null
#  identifier :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Embed < ApplicationRecord
  has_one :article_block, as: :blockable, dependent: :destroy
  has_one :article, through: :article_block

  enum embed_type: { youtube: 0, twitter: 1 }

  validates :identifier, length: { maximum: 200 }

  def split_id_from_youtube_url
    identifier.split('/').last if youtube?
  end
end
