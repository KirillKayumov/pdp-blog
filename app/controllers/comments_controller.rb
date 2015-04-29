class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i(create destroy)
  before_action :authorize_user!, only: :destroy

  rescue_from Pundit::NotAuthorizedError, with: :redirect_with_alert

  respond_to :js

  expose(:article)
  expose(:comments, ancestor: :article)
  expose(:comment, attributes: :comment_params)
  expose(:comment_presenter) { CommentPresenter.wrap(comment) }

  def create
    comment.user = current_user
    comment.save
    respond_with comment
  end

  def destroy
    comment.destroy
    respond_with comment
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def authorize_user!
    authorize(comment, :manage?)
  end
end
