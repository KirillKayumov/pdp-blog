class CommentQuery
  def initialize(relation = Comment)
    @relation = relation
  end

  def search
    @relation
      .comments
      .ordered
      .includes(:user)
  end
end
