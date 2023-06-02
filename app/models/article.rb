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

class Article < ApplicationRecord
  belongs_to :category
  belongs_to :author

  has_many :article_tags
  has_many :tags, through: :article_tags
  has_many :article_blocks, -> { order(:level) }, inverse_of: :article
  has_many :sentences, through: :article_blocks, source: :blockable, source_type: 'Sentence'
  has_many :media, through: :article_blocks, source: :blockable, source_type: 'Medium'
  has_many :embeds, through: :article_blocks, source: :blockable, source_type: 'Embed'

  has_one_attached :eye_catch

  enum state: { draft: 0, published: 1, publish_wait: 2 }

  validates :slug, slug_format: true, uniqueness: true, length: { maximum: 255 }, allow_blank: true
  validates :title, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :description, length: { maximum: 1000 }, allow_blank: true
  validates :state, presence: true
  validates :eye_catch, attachment: { purge: true, content_type: %r{\Aimage/(png|jpeg)\Z}, maximum: 10_485_760 }

  with_options if: :published? do
    validates :slug, slug_format: true, presence: true, length: { maximum: 255 }
    validates :published_at, presence: true
    validates :category_id, presence: true
  end

  delegate :name, to: :category, prefix: true, allow_nil: true
  delegate :slug, to: :category, prefix: true, allow_nil: true
  delegate :name, to: :author, prefix: true, allow_nil: true

  before_create -> { self.uuid = SecureRandom.uuid }

  scope :viewable, -> { published.where('published_at < ?', Time.current) }
  scope :new_arrivals, -> { viewable.order(published_at: :desc) }
  scope :by_category, ->(category_id) { where(category_id: category_id) }
  scope :title_contain, ->(word) { where('title LIKE ?', "%#{word}%") }
  scope :past_published, -> { where('published_at <= ?', Time.current) }

  def build_body(controller)
    result = ''

    article_blocks.each do |article_block|
      result << if article_block.sentence?
                  sentence = article_block.blockable
                  sentence.body ||= ''
                elsif article_block.medium?
                  medium = ActiveDecorator::Decorator.instance.decorate(article_block.blockable)
                  controller.render_to_string("shared/_media_#{medium.media_type}", locals: { medium: medium }, layout: false)
                elsif article_block.embed?
                  embed = ActiveDecorator::Decorator.instance.decorate(article_block.blockable)
                  controller.render_to_string("shared/_embed_#{embed.embed_type}", locals: { embed: embed }, layout: false)
                end
    end

    result
  end

  def publishable?
    Time.current >= published_at
  end

  def adjust_state
    return if draft?

    self.state = if publishable?
                   :published
                 else
                   :publish_wait
                 end
  end

  def message_on_published
    if published?
      '記事を公開しました'
    elsif publish_wait?
      '記事を公開待ちにしました'
    end
  end

  def next_article
    @next_article ||= Article.viewable.order(published_at: :asc).find_by('published_at > ?', published_at)
  end

  def prev_article
    @prev_article ||= Article.viewable.order(published_at: :desc).find_by('published_at < ?', published_at)
  end
end
