class ArticlesController < ApplicationController
  expose(:decorated_articles) { Article.ordered.includes(:user).decorate }

  def index
  end
end
