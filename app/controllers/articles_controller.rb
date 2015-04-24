class ArticlesController < ApplicationController
  expose(:decorated_articles) { Article.ordered.includes(:user).decorate }
  expose(:article)
  expose(:decorated_article) { article.decorate }

  def index
  end

  def show
  end
end
