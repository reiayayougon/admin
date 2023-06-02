require 'rails_helper'

RSpec.describe "AdminArticles", type: :system do
  let(:admin) { create :user, :admin }
  let(:draft_article) { create :article, :draft }
  let(:future_article) { create :article, :future }
  let(:past_article) { create :article, :past }
  before do
    login(admin)
  end
  describe '記事編集画面' do
    context '公開日時を未来の日付に設定して「公開する」を押す' do
      it 'ステータスを「公開待ち」に変更して「記事を公開待ちにしました」とフラッシュメッセージが表示されること' do
        visit edit_admin_article_path(future_article.uuid)
        click_on '公開する'
        expect(page).to have_content('公開待ちにしました'), '「公開待ちにしました」というメッセージが表示されていません'
        expect(page).to have_select('状態', selected: '公開待ち'), 'ステータスが「公開待ち」になっていません'
      end
    end

    context '公開日時を過去の日付に設定し「公開する」を押す' do
      it 'ステータスを「公開」に変更して「記事を公開しました」とフラッシュメッセージ' do
        visit edit_admin_article_path(past_article.uuid)
        click_on '公開する'
        expect(page).to have_content('公開しました'), '「公開しました」というメッセージが表示されていません' 
        expect(page).to have_select('状態', selected: '公開'), 'ステータスが「公開」になっていません'
      end
    end

    context 'ステータスが下書き以外の状態で公開日時を未来の日付に設定し「更新する」を押す' do
      it 'ステータスを「公開待ち」に変更して「更新しました」とフラッシュメッセージが表示されること' do
        visit edit_admin_article_path(future_article.uuid)
        click_on '更新する'
        expect(page).to have_content('更新しました'), '「更新しました」というメッセージが表示されていません'
        expect(page).to have_select('状態', selected: '公開待ち'), 'ステータスが「公開待ち」になっていません'
      end
    end
    
    context 'ステータスが下書き以外の状態で公開日時を過去の日付に設定し「更新する」を押す' do
      it 'ステータスを「公開」に変更して「更新しました」とフラッシュメッセージが表示されること' do
        visit edit_admin_article_path(past_article.uuid)
        click_on '更新する'
        expect(page).to have_content('更新しました'), '「更新しました」というメッセージが表示されていません'
        expect(page).to have_select('状態', selected: '公開'), 'ステータスが「公開」になっていません'
      end
    end

    context 'ステータスが下書き状態で「更新する」を押す' do
      it 'ステータスは「下書き」のまま「更新しました」とフラッシュメッセージが表示されること' do
        visit edit_admin_article_path(draft_article.uuid)
        click_on '更新する'
        expect(page).to have_content('更新しました'), '「更新しました」というメッセージが表示されていません'
        expect(page).to have_selector(:css, '.form-control', text: '下書き'), 'ステータスが「下書き」になっていません'
      end
    end
  end
end


