require 'rails_helper'

RSpec.describe "AdminTagBreadcrumbs", type: :system do
  let(:admin) { create :user, :admin }
  before do
    login(admin)
  end
  describe 'タグ一覧画面' do
    it 'Home > タグ というパンくずが表示されていること' do
      visit admin_tags_path
      within('.breadcrumb') do
        expect(page).to have_content('Home'), '「Home」というパンくずが表示されていません'
        expect(page).to have_content('タグ'), '「タグ」というパンくずが表示されていません'
      end
    end
    it '「Home」のパンくずをクリックした時にダッシュボード画面に遷移すること' do
      visit admin_tags_path
      within('.breadcrumb') do
        click_link 'Home'
      end
      expect(current_path).to eq(admin_dashboard_path), 'パンくずのHomeを押したときにダッシュボードに遷移していません'
    end
  end

  describe 'タグ編集画面' do
    let!(:tag) { create :tag }
    it 'Home > タグ > タグ編集 というパンくずが表示されていること' do
      visit edit_admin_tag_path(tag)
      within('.breadcrumb') do
        expect(page).to have_content('Home'), '「Home」というパンくずが表示されていません'
        expect(page).to have_content('タグ'), '「タグ」というパンくずが表示されていません'
        expect(page).to have_content('タグ編集'), '「タグ編集」 というパンくずが表示されていません'
      end
    end

    it '「タグ」のパンくずをクリックした時に、タグ一覧画面に遷移すること' do
      visit edit_admin_tag_path(tag)
      within('.breadcrumb') do
        click_link 'タグ'
      end
      expect(current_path).to eq(admin_tags_path), 'パンくずの「タグ」をクリックしたときにタグ一覧画面に遷移していません'
    end
  end
end

