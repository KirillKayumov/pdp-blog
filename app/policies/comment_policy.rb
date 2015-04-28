class CommentPolicy
  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def new?
    @user.present?
  end

  def manage?
    @user.present? && @comment.user == @user
  end
end
