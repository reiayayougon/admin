# == Schema Information
#
# Table name: articles
#
#  id           :bigint           not null, primary key
#  category_id  :bigint
#  author_id    :bigint
#  uuid         :string(255)
#  slug         :string(255)
#  title        :string(255)
#  description  :text(65535)
#  body         :text(65535)
#  state        :integer          default("draft"), not null
#  published_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  deleted_at   :datetime
#
# Indexes
#
#  index_articles_on_author_id     (author_id)
#  index_articles_on_category_id   (category_id)
#  index_articles_on_deleted_at    (deleted_at)
#  index_articles_on_published_at  (published_at)
#  index_articles_on_slug          (slug)
#  index_articles_on_uuid          (uuid)
#

FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "title-#{n}" }
    sequence(:slug) { |n| "slug-#{n}" }
    category
  end

  trait :draft do
    state { :draft }
  end

  trait :future do
    published_at { DateTime.now.since(1.hours) }
    state { :publish_wait }
  end

  trait :past do
    published_at { DateTime.now.ago(1.hours) }
    state { :published }
  end
end

