class Article < ActiveRecord::Base
  belongs_to :user

  validates :title, :text, :user, presence: true

  scope :ordered, -> { order(created_at: :desc) }
end
