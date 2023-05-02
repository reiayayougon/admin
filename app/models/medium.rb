# == Schema Information
#
# Table name: media
#
#  id         :bigint           not null, primary key
#  media_type :integer          default("image"), not null
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Medium < ApplicationRecord
  has_one :article_block, as: :blockable, dependent: :destroy
  has_one :article, through: :article_block

  has_one_attached :attachment

  enum media_type: { image: 0 }

  validates :attachment, attachment: { purge: true, content_type: %r{\Aimage/(png|jpeg)\Z}, maximum: 10_485_760 }, if: :image?
end
