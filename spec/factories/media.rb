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

FactoryBot.define do
  factory :medium do
    
  end
end
