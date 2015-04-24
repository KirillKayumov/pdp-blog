class ArticleDecorator < Draper::Decorator
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::DateHelper

  TRUNCATED_TEXT_LENGTH = 1000

  decorates_association :user

  delegate :title, :text
  delegate :full_name, to: :user, prefix: true

  def text_by_paragraphs
    split_by_paragraphs(object.text)
  end

  def truncated_text_by_paragraphs
    truncated_text.split("\r\n")
  end

  def truncated_text
    truncate(object.text, length: TRUNCATED_TEXT_LENGTH, separator: ' ')
  end

  def created_at
    if object.created_at > Time.zone.yesterday
      "#{time_ago_in_words(object.created_at)} ago"
    else
      l(object.created_at)
    end
  end

  def split_by_paragraphs(text)
    text.split("\r\n")
  end
end
