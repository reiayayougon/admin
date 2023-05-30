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

  enum state: { draft: 0, published: 1 }

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

  def build_body(controller)   #3つの条件文で処理が分岐されることで、記事ブロックに含まれるいろいろなコンテンツ（文章、メディアファイル、埋め込みコンテンツ）に対応したHTMLを生成している
    result = ''

    article_blocks.each do |article_block|
      result << if article_block.sentence?     #記事がブロックの場合、その文章をresultの後ろに追加
                  sentence = article_block.blockable
                  sentence.body ||= ''
                elsif article_block.medium?    #記事ブロックが中間要素の場合、render_to_string(ビューを文字列として取得)メソッドを使って_media_#{medium.media_type}パーシャルビューファイル（app/views/shared/_media_#{medium.media_type}.html.erb）を呼び出し、local変数mediumを渡しています。このビューでは、mediumオブジェクトの情報を使用して、ページ上にメディアを表示するためのHTMLを生成
                  medium = ActiveDecorator::Decorator.instance.decorate(article_block.blockable)
                  controller.render_to_string("shared/_media_#{medium.media_type}", locals: { medium: medium }, layout: false)
                elsif article_block.embed? #embedメソッドで要素が埋め込み要素か否かを真偽地で返すメソッド  ここの場合埋め込みコンテンツブロックの場合に使用され、埋め込みオブジェクトの情報を取得しembedとという名前のローカル変数に渡す。このビューでは、embedオブジェクトの情報を使用して、該当する埋め込みコンテンツを表示するためのHTMLを生成
                  embed = ActiveDecorator::Decorator.instance.decorate(article_block.blockable)
                  controller.render_to_string("shared/_embed_#{embed.embed_type}", locals: { embed: embed }, layout: false)
                end
    end

    result
  end

  def next_article
    @next_article ||= Article.viewable.order(published_at: :asc).find_by('published_at > ?', published_at)
  end

  def prev_article
    @prev_article ||= Article.viewable.order(published_at: :desc).find_by('published_at < ?', published_at)
  end
end
