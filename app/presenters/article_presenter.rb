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

  def managed_by?(user)
    ArticlePolicy.new(user, object).manage?
  end
end
