class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i(new create edit update destroy)
  before_action :require_permission, only: %i(create edit update destroy)

  respond_to :html
  respond_to :js, only: :index

  expose(:all_articles) do
    ArticleQuery.new
      .search
      .paginate(page: params[:page], per_page: 5)
  end
  expose(:decorated_articles) { all_articles.decorate }

  expose(:article, attributes: :article_params)
  expose(:decorated_article) { article.decorate }

  expose(:comments) do
    CommentQuery.new(article)
      .search
      .paginate(page: params[:page], per_page: 5)
  end
  expose(:decorated_comments) { comments.decorate }

  def index
  end

  def show
  end

  def new
  end

  def create
    article.save
    respond_with article, location: root_path
  end

  def edit
  end

  def update
    article.save
    respond_with article
  end

  def destroy
    article.destroy
    respond_with article, location: root_path
  end

  private

  def article_params
    params.require(:article).permit(
      :title,
      :text,
      :user_id
    )
  end

  def access_allowed?
    ArticlePolicy.new(current_user, article).send("#{action_name}?")
  end
end
