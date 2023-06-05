class SearchArticlesForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :author_id, :integer
  attribute :tag_id, :integer
  attribute :body, :string
  attribute :category_id, :integer
  attribute :title, :string

  def search
    relation = Article.distinct

    title_words.each do |word|
      relation = relation.title_contain(word)
    end
    relation = relation.by_author(author_id) if author_id.present?
    relation = relation.by_tag(tag_id) if tag_id.present?
    body_words.each do |word|
      relation = relation.body_contain(word)
    end
    relation
  end

  private

  def title_words
    title.present? ? title.split(nil) : []
  end

  def body_words
    body.present? ? body.split(nil) : []
  end
end
