class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user

  validates :text, :article, :user, presence: true

  scope :ordered, -> { order(created_at: :asc) }
end
