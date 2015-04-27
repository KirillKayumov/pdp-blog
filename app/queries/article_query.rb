class ArticleQuery
  def initialize(relation = Article)
    @relation = relation
  end

  def search
    @relation
      .ordered
      .includes(:user)
  end
end
