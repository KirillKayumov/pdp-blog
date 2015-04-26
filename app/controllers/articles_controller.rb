class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i(new create edit update destroy)
  before_action :require_permission, only: %i(create edit update destroy)

  respond_to :js, only: :index

  expose(:all_articles) do
    Article
      .ordered
      .includes(:user)
      .paginate(page: params[:page], per_page: 5)
  end
  expose(:decorated_articles) { all_articles.decorate }
  expose(:article, attributes: :article_params)
  expose(:decorated_article) { article.decorate }
  expose(:comments) do
    article
      .comments
      .ordered
      .includes(:user)
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
    if article.save
      redirect_to root_path, notice: t('app.messages.article.created')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if article.save
      redirect_to article, notice: t('app.messages.article.updated')
    else
      render :edit
    end
  end

  def destroy
    article.destroy!
    redirect_to root_path, notice: t('app.messages.article.destroyed')
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
