class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i(new create edit update destroy)
  before_action :authorize_user!, only: %i(create edit update destroy)

  rescue_from Pundit::NotAuthorizedError, with: :redirect_with_alert

  respond_to :html
  respond_to :js, only: :index

  expose(:all_articles) do
    Article
      .ordered
      .with_users
      .paginate(page: params[:page], per_page: 5)
  end
  expose(:decorated_articles) { all_articles.decorate }

  expose(:article, attributes: :article_params)
  expose(:decorated_article) { article.decorate }

  expose(:comments, ancestor: :article) do |default|
    default
      .ordered
      .with_users
      .paginate(page: params[:page], per_page: 5)
  end
  expose(:decorated_comments) { comments.decorate }
  expose(:comment) { Comment.new }

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
    params.require(:article).permit(:title, :text).merge(user: current_user)
  end

  def authorize_user!
    authorize(article, :manage?)
  end
end
