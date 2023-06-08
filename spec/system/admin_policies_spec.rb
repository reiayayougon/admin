require 'rails_helper'

RSpec.describe "AdminPolicies", type: :system do
  let(:writer) { create(:user, :writer) }
  let(:editor) { create(:user, :editor) }
  let(:admin) { create(:user, :admin) }
  let!(:tag) { create :tag }
  let!(:category) { create :category }
  let!(:author) { create :author }
  before do
    driven_by(:rack_test)
  end

  describe "ライターのアクセス権限" do
    before do
      login(writer)
      visit admin_articles_path
    end

    context 'ダッシュボードページにアクセス' do
      it 'カテゴリページの表示がされていないこと' do
        expect(page).not_to have_link('カテゴリー'), 'ライターがダッシュボードにアクセスした際に、カテゴリーが表示されています'
      end

      it 'タグページのリンクが表示されていないこと' do
        expect(page).not_to have_link('タグ'), 'ライターがダッシュボードにアクセスした際に、タグが表示されています'
      end

      it '著者ページのリンクが表示されていないこと' do
        expect(page).not_to have_link('著者'), 'ライターがダッシュボードにアクセスした際に、著者が表示されています'
      end
    end

    context 'カテゴリー一覧ページにアクセスした' do
      it 'アクセス失敗となり、403エラーが表示されること' do
        visit admin_categories_path
        expect(page).to have_http_status(403), 'カテゴリー一覧ページのアクセスに成功しています'
        expect(page).not_to have_content(category.name), 'カテゴリー一覧ページの表示がライターに表示されています'
      end
    end

    context 'カテゴリー編集ページにアクセスした' do
      it 'アクセスは失敗となり、403エラーが表示されること' do
        visit edit_admin_category_path(category)
        expect(page).to have_http_status(403), 'カテゴリー編集ページのアクセスに成功しています'
        expect(page).not_to have_selector("input[value=#{category.name}]"), 'カテゴリー編集ページの内容がライターに表示されています'
      end
    end

    context 'タグ一覧ページにアクセスした' do
      it 'アクセスは失敗となり、403エラーが表示されること' do
        visit admin_tags_path
        expect(page).to have_http_status(403), 'タグ一覧ページのアクセスに成功しています'
        expect(page).not_to have_content(tag.name), 'タグ一覧ページの内容がライターに表示されています'
      end
    end

    context 'タグ編集ページにアクセスした' do
      it 'アクセスは失敗となり、403エラーが表示されること' do
        visit edit_admin_tag_path(tag)
        expect(page).to have_http_status(403), 'タグ編集ページのアクセスに成功しています'
        expect(page).not_to have_selector("input[value=#{tag.name}]"), 'タグ編集ページの内容がライターに表示されています'
      end
    end

    context '著者一覧ページにアクセスした' do
      it 'アクセスは失敗となり、403エラーが表示されること' do
        visit admin_authors_path
        expect(page).to have_http_status(403), '著者一覧ページのアクセスに成功しています'
        expect(page).not_to have_content(author.name), '著者一覧ページの内容がライターに表示されています'
      end
    end

    context '著者編集ページにアクセスした' do
      it 'アクセスは失敗となり、403エラーが表示されること' do
        visit edit_admin_author_path(author)
        expect(page).to have_http_status(403), '著者編集ページのアクセスに成功しています'
        expect(page).not_to have_selector("input[value=#{author.name}]"), '著者編集ページの内容がライターに表示されています'
      end
    end
  end

  describe '編集者のアクセス権限' do
    before do
      login(editor)
      visit admin_articles_path
    end

    context 'ダッシュボードページにアクセスした' do
      it 'カテゴリページのリンクが表示されること' do
        expect(page).to have_link('カテゴリ'), '編集者がダッシュボードにアクセスした際、カテゴリーが表示されていません'
      end
  
      it 'タグページのリンクが表示されること' do
        expect(page).to have_link('タグ'), '編集者がダッシュボードにアクセスした際、タグが表示されていません'
      end
    
      it '著者ページのリンクが表示されること' do
        expect(page).to have_link('著者'), '編集者がダッシュボードにアクセスした際、著者が表示されていません'
      end
    end

    context 'カテゴリー一覧ページにアクセスした' do
      it 'アクセス成功となり、カテゴリー一覧が表示されること' do
        visit admin_categories_path 
        expect(page).to have_http_status(200), 'カテゴリー一覧ページのアクセスに失敗しています'
        expect(page).to have_content(category.name), 'カテゴリー一覧の表示が編集者に表示されていません'
      end
    end

    context 'カテゴリー編集ページにアクセスした' do
      it 'アクセス成功となり、カテゴリー一覧が表示されること' do
        visit edit_admin_category_path(category)
        expect(page).to have_http_status(200), 'カテゴリー編集ページのアクセスに失敗しています'
        expect(page).to have_selector("input[value=#{category.name}]"), 'カテゴリー編集ページの内容が編集者に表示されていません'
      end
    end

    context 'タグ一覧ページにアクセスした' do
      it 'アクセス成功となり、タグ一覧が表示されること' do
        visit admin_tags_path 
        expect(page).to have_http_status(200), 'タグ一覧ページのアクセスに失敗してます'
        expect(page).to have_content(tag.name), 'タグ一覧の表示が編集者に表示されていません'
      end
    end

    context 'タグ編集ページにアクセスした' do 
      it 'アクセス成功となり、タグ編集が表示されること' do
        visit edit_admin_tag_path(tag)
        expect(page).to have_http_status(200), 'タグ編集ページのアクセスに失敗してます'
        expect(page).to have_selector("input[value=#{tag.name}]"), 'タグ編集ページの内容が編集者に表示されていません'
      end
    end
    
    context '著者一覧ページにアクセスした' do
      it 'アクセス成功となり、著者一覧が表示されること' do
        visit admin_authors_path
        expect(page).to have_http_status(200), '著者一覧ページのアクセスに失敗してます'
        expect(page).to have_content(author.name), '著者一覧の表示が編集者に表示されていません'
      end
    end

    context '著者編集ページにアクセスした' do
      it 'アクセス成功となり、著者編集ページが表示されること' do
        visit  edit_admin_author_path(author)
        expect(page).to have_http_status(200), '著者編集ページのアクセスに失敗してます'
        expect(page).to have_selector("input[value=#{author.name}]"), '著者編集ページの内容が編集者に表示されていません'
      end
    end
  end

  describe '管理者のアクセス権限' do
    before do
      login(admin)
      visit admin_articles_path
    end

    context 'ダッシュボードページにアクセス' do
      it 'カテゴリページのリンクが表示されること' do
        expect(page).to have_link('カテゴリ'), '管理者がダッシュボードにアクセスした際、カテゴリーが表示されていません'
      end

      it 'タグページのリンクが表示されること' do
        expect(page).to have_link('タグ'), '管理者がダッシュボードにアクセスした際、タグが表示されていません'
      end

      it '著者ページのリンクが表示されること' do
        expect(page).to have_link('著者'), '管理者がダッシュボードにアクセスした際、著者が表示されていません'
      end
    end

    context 'カテゴリー一覧ページにアクセスした' do
      it 'アクセス成功となり、カテゴリー一覧が表示されること' do
        visit admin_categories_path 
        expect(page).to have_http_status(200), '管理者がカテゴリー一覧ページのアクセスに失敗しています'
        expect(page).to have_content(category.name), 'カテゴリー一覧の表示が管理者に表示されていません'
      end
    end

    context 'カテゴリー編集ページにアクセスした' do
      it 'アクセス成功となり、カテゴリー一覧が表示されること' do
        visit edit_admin_category_path(category)
        expect(page).to have_http_status(200), '管理者がカテゴリー編集ページのアクセスに失敗しています'
        expect(page).to have_selector("input[value=#{category.name}]"), 'カテゴリー編集ページの内容が管理者に表示されていません'
      end
    end

    context 'タグ一覧ページにアクセスした' do
      it 'アクセス成功となり、タグ一覧が表示されること' do
        visit admin_tags_path 
        expect(page).to have_http_status(200), 'タグ一覧ページのアクセスに失敗してます'
        expect(page).to have_content(tag.name), 'タグ一覧の表示が管理者に表示されていません'
      end
    end

    context 'タグ編集ページにアクセスした' do 
      it 'アクセス成功となり、タグ編集が表示されること' do
        visit edit_admin_tag_path(tag)
        expect(page).to have_http_status(200), '管理者がタグ編集ページのアクセスに失敗してます'
        expect(page).to have_selector("input[value=#{tag.name}]"), 'タグ編集ページの内容が管理者に表示されていません'
      end
    end
    
    context '著者一覧ページにアクセスした' do
      it 'アクセス成功となり、著者一覧が表示されること' do
        visit admin_authors_path
        expect(page).to have_http_status(200), '管理者が著者一覧ページのアクセスに失敗してます'
        expect(page).to have_content(author.name), '著者一覧の表示が管理者に表示されていません'
      end
    end

    context '著者編集ページにアクセスした' do
      it 'アクセス成功となり、著者編集ページが表示されること' do
        visit  edit_admin_author_path(author)
        expect(page).to have_http_status(200), '管理者が著者編集ページのアクセスに失敗してます'
        expect(page).to have_selector("input[value=#{author.name}]"), '著者編集ページの内容が管理者に表示されていません'
      end
    end
  end
end