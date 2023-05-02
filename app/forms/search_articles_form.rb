class SearchArticlesForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :category_id, :integer
  attribute :title, :string

  def search
    relation = Article.distinct

    relation = relation.by_category(category_id) if category_id.present?
    title_words.each do |word|
      relation = relation.title_contain(word)
    end
    relation
  end

  private

  def title_words
    title.present? ? title.split(nil) : []
  end
end
