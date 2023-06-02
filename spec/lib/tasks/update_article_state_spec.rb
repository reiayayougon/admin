require 'rake_helper'

describe 'article_state:update_article_state' do
    subject(:task) { Rake.application['article_state:update_article_state'] }
    before do
        create(:article, state: :publish_wait, published_at: Time.current - 1.day)
        create(:article, state: :publish_wait, published_at: Time.current + 1.day)
        create(:article, state: :draft)
    end

    it 'update_article_state' do
        expect { task.invoke }.to change { Article.published.size }.from(0).to(1)
    end
end
