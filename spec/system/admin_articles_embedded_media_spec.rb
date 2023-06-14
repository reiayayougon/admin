require 'rails_helper'

RSpec.describe "AdminArticlesEmbeddedMedia", type: :system do
  let(:admin) { create(:user, :admin)}
  let(:article) { create :article}

  describe '記事の埋め込みブロックを追加' do
    before do
      login(admin)
      article
      visit edit_admin_article_path(article.uuid)
      click_on 'ブロックを追加する'
      click_link '埋め込み'
      click_link '編集'
    end

    context 'Youtubeを選択しアップロード' do
      it 'プレビューした記事にYoutubeが埋め込まれている' do
        select 'YouTube', from: 'embed[embed_type]'
        fill_in 'ID', with: 'https://youtu.be/dZ2dcC4OnQE'
        page.all('.box-footer')[0].click_button('更新する')
        click_on('プレビュー')
        switch_to_window(windows.last)
        expect(current_path).to eq(admin_article_preview_path(article.uuid)), '更新した記事を正しくプレビューできていません'
        expect(page).to have_selector("iframe[src='https://www.youtube.com/embed/dZ2dcC4OnQE']"), 'プレビューにYoutubeがアップロードされていません'
      end
    end

    context 'Twitterを選択しアップロード' do
      it 'プレビューした記事にTwitterが埋め込まれている' do
        select 'Twitter', from: 'embed[embed_type]'
        fill_in 'ID', with: 'https://twitter.com/sharenewsjapan1/status/1668773068930416640'
        page.all('.box-footer')[0].click_button('更新する')
        click_on('プレビュー')
        switch_to_window(windows.last)
        expect(current_path).to eq(admin_article_preview_path(article.uuid)), '更新した記事を正しくプレビューできていません'
        sleep 5
        expect(page).to have_selector(".twitter-tweet"), 'プレビューにTwitterがアップロードされていません'
      end
    end
  end
end
