class CommentsController < ApplicationController
  respond_to :js

  before_action :authenticate_user!, only: :create
  before_action :require_permission, only: :create

  expose(:article)
  expose(:comments, ancestor: :article)
  expose(:comment, attributes: :comment_params)
  expose(:decorated_comment) { comment.decorate }

  def create
    comment.save
    respond_with comment
  end

  private

  def comment_params
    params.require(:comment).permit(
      :text,
      :user_id
    )
  end

  def access_allowed?
    CommentPolicy.new(current_user, comment).send("#{action_name}?")
  end
end
