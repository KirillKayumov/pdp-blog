class ArticlePresenter < ApplicationPresenter
  attr_reader :object

  delegate :title, :text, :user, to: :object

  def initialize(object)
    @object = object
  end

  def text_by_paragraphs
    split_by_paragraphs(text)
  end

  def to_partial_path
    'articles/article'
  end

  def author
    user.full_name
  end

  def link_to_edit(current_user)
    link_to(I18n.t('app.actions.edit'), edit_article_path(object)) if can_manage?(current_user)
  end

  def link_to_destroy(current_user)
    link_to(
      I18n.t('app.actions.destroy'),
      article_path(object),
      method: :delete,
      data: { confirm: I18n.t('app.messages.sure') }
    ) if can_manage?(current_user)
  end

  private

  def can_manage?(current_user)
    ArticlePolicy.new(current_user, object).manage?
  end
end
