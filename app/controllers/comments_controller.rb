class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i(create destroy)
  before_action :authorize_user!, only: %i(create destroy)

  rescue_from Pundit::NotAuthorizedError, with: :redirect_to_root

  respond_to :js

  expose(:article)
  expose(:comments, ancestor: :article)
  expose(:comment, attributes: :comment_params)
  expose(:decorated_comment) { comment.decorate }

  def create
    comment.save
    respond_with comment
  end

  def destroy
    comment.destroy
    respond_with comment
  end

  private

  def comment_params
    params.require(:comment).permit(
      :text,
      :user_id
    )
  end

  def authorize_user!
    authorize(comment, :manage?)
  end
end
