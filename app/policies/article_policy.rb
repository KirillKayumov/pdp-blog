class ArticlePolicy
  def initialize(user, article)
    @user = user
    @article = article
  end

  def manage?
    @user.present? && @article.user == @user
  end
end
