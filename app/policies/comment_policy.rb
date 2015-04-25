class CommentPolicy
  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def new?
    @user.present?
  end

  def create?
    return false unless @user.present?

    @comment.user_id == @user.id
  end
  alias_method :destroy?, :create?
end
