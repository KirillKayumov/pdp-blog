class Comment < ActiveRecord::Base
  belongs_to :article, counter_cache: true
  belongs_to :user

  validates :text, :article, :user, presence: true

  scope :ordered, -> { order(created_at: :asc) }
  scope :with_users, -> { includes(:user) }
end
