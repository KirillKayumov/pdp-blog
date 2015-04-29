class ApplicationPresenter
  include ActionView::Helpers::DateHelper

  def self.wrap(object_or_collection)
    if object_or_collection.respond_to?(:map)
      object_or_collection.map { |item| new(item) }
    else
      new(object_or_collection)
    end
  end

  def split_by_paragraphs(text)
    text.split("\r\n")
  end

  def created_at
    if object.created_at > Time.zone.yesterday
      "#{time_ago_in_words(object.created_at)} ago"
    else
      I18n.localize(object.created_at)
    end
  end
end
