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

FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "test_tag_name_#{n}" }
    sequence(:slug) { |n| "tesut_tag_slug_#{n}" }
  end
end
