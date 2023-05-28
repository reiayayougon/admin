# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  name             :string(255)      not null
#  crypted_password :string(255)
#  role             :integer          default("writer")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  deleted_at       :datetime
#
# Indexes
#
#  index_users_on_deleted_at  (deleted_at)
#  index_users_on_name        (name)
#

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "admin-#{n}" }
    password { 'password' }
    password_confirmation { 'password' }
    role { :admin }

    trait :admin do
      sequence(:name) { |n| "admin-#{n}" }
      role { :admin }
    end

    trait :editor do
      sequence(:name) { |n| "editor-#{n}" }
      role { :editor }
    end

    trait :writer do
      sequence(:name) { |n| "writer-#{n}" }
      role { :writer }
    end
  end
end
