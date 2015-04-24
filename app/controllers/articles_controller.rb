class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i(new create)

  expose(:decorated_articles) { Article.ordered.includes(:user).decorate }
  expose(:article, attributes: :article_params)
  expose(:decorated_article) { article.decorate }

  def index
  end

  def show
  end

  def new
  end

  def create
    if article.save
      redirect_to root_path, notice: t('app.messages.article.success')
    else
      render :new
    end
  end

  private

  def article_params
    params.require(:article).permit(
      :title,
      :text,
      :user_id
    )
  end
end
