# == Schema Information
#
# Table name: taxonomies
#
#  id          :bigint           not null, primary key
#  type        :string(255)
#  name        :string(255)
#  slug        :string(255)
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_taxonomies_on_slug  (slug)
#  index_taxonomies_on_type  (type)
#

class Author < Taxonomy
  has_many :articles

  has_one_attached :avatar

  validates :avatar, attachment: { purge: true, content_type: %r{\Aimage/(png|jpeg)\Z}, maximum: 10_485_760 }
end
