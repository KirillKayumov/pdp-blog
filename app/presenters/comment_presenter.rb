class CommentPresenter < ApplicationPresenter
  attr_reader :object

  delegate :text, :user, to: :object

  def initialize(object)
    @object = object
  end

  def text_by_paragraphs
    split_by_paragraphs(text)
  end

  def to_partial_path
    'comments/comment'
  end

  def author
    user.full_name
  end

  def link_to_destroy(current_user, article)
    link_to(
      I18n.t('app.actions.destroy'),
      article_comment_path(article, object),
      method: :delete,
      remote: true,
      data: { confirm: I18n.t('app.messages.sure') }
    ) if can_manage?(current_user)
  end

  private

  def can_manage?(current_user)
    ArticlePolicy.new(current_user, object).manage?
  end
end
