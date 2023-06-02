require 'rails_helper'

RSpec.describe 'AdminArticlesPreview', type: :system do
  let(:admin) { create :user, :admin }
  before do
    login(admin)
  end

  describe '記事作成画面で画像ブロックを追加' do
    context '画像を添付せずにプレビューを閲覧' do
      it '正常に表示される' do
        click_link '記事'
        visit admin_articles_path
        click_link '新規作成'
        fill_in 'タイトル', with: 'テスト記事'
        fill_in 'スラッグ', with: 'test'
        click_button('登録する')
        click_link 'ブロックを追加する'
        click_link '画像'
        click_link 'プレビュー'
        switch_to_window(windows.last)
        expect(page).not_to have_content("Nil location provided. Can't build URI"), 'エラーページが表示されています'
        expect(page).to have_content('テスト記事'), 'プレビューページが正しく表示されていません'
      end
    end
  end
  
  describe '記事作成画面で文章ブロック追加' do
    let!(:article) { create :article }
    context '文章空欄でプレビューを閲覧' do
      it '記事プレビュー画面に遷移できることを確認' do
        visit edit_admin_article_path(article.uuid)
        click_link 'ブロックを追加する'
        click_link '文章'
        click_link 'プレビュー'
        switch_to_window(windows.last) #最後に開いたタブに移動
        expect(page).to have_content(article.title), 'プレビューが正しく表示されていません'
        expect(page).not_to have_content('no implicit conversion of nil into String'), 'プレビューページがエラー画面になっています'
      end
    end
  end
end
