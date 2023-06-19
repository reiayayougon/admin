require 'rails_helper'

RSpec.describe "AdminSites", type: :system do
  let(:admin) { create(:user, :admin) }
  let!(:article) { create :article }

  before do
    login(admin)
    visit edit_admin_site_path
  end

  describe 'ブログのトップ画像を変更' do
    context 'トップ画像を一枚選択してアップロード' do
      it 'トップ画像が登録されること' do
        attach_file('site_main_images', 'spec/fixtures/images/runteq_man_top.png')
        click_on '保存'
        expect(page).to have_selector("img[src$='runteq_man_top.png']"), 'トップ画像のアップロードができていません'
      end
    end

    context 'トップ画像を複数枚選択してアップロード' do
      it 'トップ画像が複数選択されること' do
        attach_file('site_main_images', %w(spec/fixtures/images/runteq_man_top.png spec/fixtures/images/runteq_man.png))
        click_on '保存'
        expect(page).to have_selector("img[src$='runteq_man.png']"), '複数のトップ画像のアップロードができていません'
        expect(page).to have_selector("img[src$='runteq_man_top.png']"), '複数のトップ画像のアップロードができていません'
      end
    end

    context 'アップロード済みのトップ画像を削除' do
      it 'トップ画像が削除されること' do
        attach_file('site_main_images', 'spec/fixtures/images/runteq_man_top.png')
        click_on '保存'
        expect(page).to have_selector("img[src$='runteq_man_top.png']"), 'トップ画像のアップロードができていません'
        click_link '削除'
        expect(page).not_to have_selector("img[src$='runteq_man_top.png']"), '選択した画像が削除できていません'
      end
    end
  end

  describe 'favicon画像を変更' do
    context 'favicon画像を1枚選択してアップロード' do
      it 'favicon画像がアップロードされてること' do
        attach_file('site_favicon', 'spec/fixtures/images/runteq_man.png')
        click_on '保存'
        expect(page).to have_selector("img[src$='runteq_man.png']"), 'favicon画像がアップロードされていません'
      end
    end

    context 'アップロード済みのfaviconを削除' do
      it 'favicon画像が削除されていること' do
        attach_file('site_favicon', 'spec/fixtures/images/runteq_man.png')
        click_on '保存'
        expect(page).to have_selector("img[src$='runteq_man.png']"), 'favicon画像のアップロードができていません'
        click_link '削除'
        expect(page).not_to have_selector("img[src$='runteq_man.png']"), 'アップロードされた画像が削除されていません'
      end
    end
  end

  describe 'og_image画像を変更' do
    context 'og_image画像を1枚選択してアップロード' do
      it 'og_image画像がアップロードされていること' do
        attach_file('site_og_image', 'spec/fixtures/images/runteq_man_top.png')
        click_on '保存'
        expect(page).to have_selector("img[src$='runteq_man_top.png']"), 'og_image画像がアップロードされていません'
      end
    end

    context 'アップロード済みのog_image画像を削除' do
      it 'og_image画像が削除されること' do
        attach_file('site_og_image', 'spec/fixtures/images/runteq_man_top.png')
        click_on '保存'
        expect(page).to have_selector("img[src$='runteq_man_top.png']"), 'od_image画像のアップロードができていません'
        click_link '削除'
        expect(page).not_to have_selector("img[src$='runteq_man_top.png']"), 'アップロードされた画像が削除されていません'
      end
    end
  end
end



        

  
  
