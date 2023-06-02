class Admin::Articles::PublishesController < ApplicationController
  layout 'admin'

  before_action :set_article

  def update
    @article.published_at = Time.current unless @article.published_at?  #記事が公開されていない場合自動的に現在時刻が公開日として設定。具体的にはpublished_at?が設定されてるかどうかチェック。されていなければTime .currentメソッドで現在時刻を代入
    @article.state = @article.publishable? ? :published : :publish_wait

    if @article.valid?
      Article.transaction do
        @article.body = @article.build_body(self)
        @article.save!
      end

      flash[:notice] = @article.message_on_published

      redirect_to edit_admin_article_path(@article.uuid)
    else
      flash.now[:alert] = 'エラーがあります。確認してください。'

      @article.state = @article.state_was if @article.state_changed?
      render 'admin/articles/edit'
    end
  end

  private

  def set_article
    @article = Article.find_by!(uuid: params[:article_uuid])
  end
end
