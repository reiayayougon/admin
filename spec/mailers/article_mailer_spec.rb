require "rails_helper"

RSpec.describe ArticleMailer, type: :mailer do
  let(:article_published_wait_tomorrow) { create(:article, :article_published_wait_tomorrow) }
  let(:article_published_yesterday) { create(:article, :article_published_yesterday) }
  let(:article_published_two_days_ago) { create(:article, :article_published_two_days_ago) }
  let(:mail) { ArticleMailer.report_summary.deliver_now }
  let(:check_sent_mail) {
    expect(mail.present?).to be_truthy, 'メールが送信されていません'
    expect(mail.to).to eq(['admin@example.com']), 'メールのタイトルが正しくありません'
    expect(mail.subject).to eq('公開済記事の集計結果'), 'メールタイトルが正しくありません'
  }

  describe '公開済みの集計結果通知メールの送信' do
    context '昨日までに公開された記事が存在しない場合' do
      it '昨日までに公開された記事がない旨の結果が送られること' do
        article_published_wait_tomorrow
        check_sent_mail
        expect(mail.body).to match('0'), '公開済記事数の件数取得結果が正しくありません'
        expect(mail.body).to match('公開済の記事数: 0件'), '公開記事数の送信フォーマットが正しくありません'
        expect(mail.body).not_to match('タイトル: ' + article_published_wait_tomorrow.title), '公開されていない記事のタイトルを取得しています'
      end
    end
  
    context '公開日が昨日の記事が存在する場合' do
      it '公開日が昨日の記事を含めた集計結果が送られること' do
        article_published_wait_tomorrow
        article_published_yesterday
        check_sent_mail
        expect(mail.body).to match('1'), '公開記事数の件数取得結果が正しくありません'
        expect(mail.body).to match('公開済の記事数: 1件'), '公開記事数の送信フォーマットが正しくありません'
        expect(mail.body).to match('昨日公開された記事数: 1件'), '昨日公開された件数取得が正しくありません'
        expect(mail.body).not_to match('タイトル: ' + article_published_wait_tomorrow.title), '昨日公開された記事のタイトルが取得されていません'
        expect(mail.body).to match(article_published_yesterday.title), '昨日公開された記事タイトルが取得されていません'
        expect(mail.body).to match('タイトル: ' + article_published_yesterday.title), '昨日公開された記事のタイトルの送信フォーマットが正しくありません'
      end
    end

    context '公開日が2日前の記事が存在する場合' do
      it '公開日が2日前の記事を含めた集計結果が送られること' do
        article_published_wait_tomorrow
        article_published_two_days_ago
        check_sent_mail
        expect(mail.body).to match('1'), '公開済記事数の件数取得結果が正しくありません'
        expect(mail.body).to match('公開済の記事数: 1件'), '公開済記事数の送信フォーマットが正しくありません'
        expect(mail.body).to match('昨日公開された記事はありません'), '昨日公開された記事の件数取得結果が正しくありません'
        expect(mail.body).not_to match('タイトル: ' + article_published_wait_tomorrow.title), '公開されていない記事のタイトルを取得しています'
        expect(mail.body).not_to match('タイトル: ' + article_published_two_days_ago.title), '昨日以前い公開された記事のタイトルを取得しています'
      end
    end

    context '公開日が昨日と2日前の記事が存在する場合' do
      it '公開日が昨日と2日前の記事を含めた集計結果が送られること' do
        article_published_wait_tomorrow
        article_published_two_days_ago
        article_published_yesterday
        check_sent_mail
        expect(mail.body).to match('2'), '公開済記事数の件数取得結果が正しくありません'
        expect(mail.body).to match('公開済の記事数: 2件'), '公開済記事数の送信フォーマットが正しくありません'
        expect(mail.body).to match('昨日公開された記事数: 1件'), '昨日公開された記事の取得件数が正しくありません'
        expect(mail.body).not_to match('タイトル ' + article_published_wait_tomorrow.title), '公開されていない記事のタイトルを取得しています'
        expect(mail.body).to match(article_published_yesterday.title), '昨日公開された記事のタイトルが取得できていません'
        expect(mail.body).to match('タイトル: ' + article_published_yesterday.title), '昨日公開された記事のタイトルの送信フォーマットが正しくありません'
        expect(mail.body).not_to match('タイトル: ' + article_published_two_days_ago.title), '昨日以前に公開された記事のタイトルを取得しています'
      end
    end
    
  end
end
