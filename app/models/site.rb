# == Schema Information
#
# Table name: sites
#
#  id          :bigint           not null, primary key
#  name        :string(255)
#  subtitle    :string(255)
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Site < ApplicationRecord
  has_one_attached :og_image
  has_one_attached :favicon
  has_many_attached :main_images

  validates :name, presence: true, length: { maximum: 100 }
  validates :subtitle, length: { maximum: 100 }
  validates :description, length: { maximum: 400 }
  validates :og_image, attachment: { purge: true, content_type: %r{\Aimage/(png|jpeg)\Z}, maximum: 524_288_000 }
  validates :favicon, attachment: { purge: true, content_type: %r{\Aimage/png\Z}, maximum: 524_288_000 }
  validates :main_images, attachment: { purg: true, content_type: %r{\Aimage/(png|jpeg)\Z}, maximun: 524_288_000 }
end
