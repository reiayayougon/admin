class Admin::Articles::PreviewsController < ApplicationController
  skip_before_action :require_login

  before_action :preview!

  def show
    @article = Article.find_by!(uuid: params[:article_uuid])
    @article.body = @article.build_body(self)
  end
end
