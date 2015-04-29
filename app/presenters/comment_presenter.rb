class CommentPresenter < ApplicationPresenter
  attr_reader :object

  delegate :text, :user, to: :object

  def self.model_name
    Comment.model_name
  end

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

  def managed_by?(user)
    CommentPolicy.new(user, object).manage?
  end

  def created_by?(user)
    CommentPolicy.new(user, object).new?
  end
end
