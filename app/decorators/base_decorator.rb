class BaseDecorator < Draper::Decorator
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::DateHelper

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
