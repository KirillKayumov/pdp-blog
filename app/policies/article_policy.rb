class ArticlePolicy
  def initialize(user, article)
    @user = user
    @article = article
  end

  def edit?
    @article.user_id == @user.id
  end
  alias_method :create?, :edit?
  alias_method :update?, :edit?
end
