require 'rails_helper'

RSpec.describe "AdminArticlesEyecatches", type: :system do
  let!(:article) { create :article }
  let(:admin) { create :user, :admin }
  
  before do
    login(admin)
    visit admin_articles_path
    click_link '編集', href: edit_admin_article_path(article.uuid)
    click_button '更新する'
    attach_file 'article[eye_catch]', "#{Rails.root}/spec/fixtures/images/runteq_man.png"
  end

  describe 'アイキャッチの横幅を変更' do
    context '横幅を100~700pxに設定した場合' do
      it '記事の更新に成功し、プレビューでアイキャッチが確認できる' do
        eyecatch_width = rand(100..700)
        fill_in 'article[eyecatch_width]', with: eyecatch_width
        click_button '更新する'
        expect(page).to have_content('更新しました')
        save_and_open_page
        click_link('プレビュー')
        switch_to_window(windows.last)
        expect(page).to have_css('.eye_catch'), 'プレビューページにeye_catchというclassが存在しません'
        expect(current_path).to eq(admin_article_preview_path(article.uuid)), '編集した記事のページに遷移してません'
        expect(page).to have_selector("img[src$='runteq_man.png']"), '画像が正しくアップロードされていません'
      end
    end

    context '横幅を99px以下で設定した場合' do
      it '記事の更新に失敗しする' do
        fill_in 'article_eyecatch_width', with: rand(99)
        click_button '更新する'
        expect(page).not_to have_content('更新しました'), '横幅のバリデーションが正しく設定されていません'
        expect(page).to have_content('は100以上の値にしてください'), 'エラーメッセージが正しく表示されていません'
      end
    end

    context '横幅を701px以上に設定した場合' do
      it '記事の更新に失敗する' do
        fill_in 'article_eyecatch_width', with: rand(701..1000)
        click_button '更新する'
        expect(page).not_to have_content('更新しました'), '横幅のバリデーションが正しく設定されていません'
        expect(page).to have_content('は700以下の値にしてください'), 'エラーメッセージが正しく設定されていません'
      end
    end
  end

  describe 'アイキャッチの表示位置を変更' do
    context 'アイキャッチ画像を「右寄せ」に設定した場合' do
      it 'アイキャッチが「右寄せ」で表示される' do
        choose '右寄せ'
        click_button '更新する'
        click_link 'プレビュー'
        switch_to_window(windows.last)
        expect(page).to have_selector('section.eye_catch.text-right'), 'アイキャッチが「右寄せ」で表示されていません'
      end
    end

    context 'アイキャッチ画像を「中央」に設定した場合' do 
      it 'アイキャッチが「中央」で表示される' do
        choose '中央'
        click_button '更新する'
        click_link 'プレビュー'
        switch_to_window(windows.last)
        expect(page).to have_selector('section.eye_catch.text-center'), 'アイキャッチが「中央」で表示されていません'
      end
    end

    context 'アイキャッチ画像を「左寄せ」に設定した場合' do
      it 'アイキャッチが「左寄せ」で表示されてる' do
        choose '左寄せ'
        click_button '更新する'
        click_link 'プレビュー'
        switch_to_window(windows.last)
        expect(page).to have_selector('section.eye_catch.text-left'), 'アイキャッチが「左寄せ」で表示されていません'
      end
    end
  end 
end
