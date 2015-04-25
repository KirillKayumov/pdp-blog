class CommentDecorator < BaseDecorator
  decorates_association :user

  delegate :text
  delegate :full_name, to: :user, prefix: true

  def text_by_paragraphs
    split_by_paragraphs(object.text)
  end
end
