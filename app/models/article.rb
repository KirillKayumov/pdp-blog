class Article < ActiveRecord::Base
  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :title, :text, :user, presence: true

  scope :ordered, -> { order(created_at: :desc) }
  scope :with_users, -> { includes(:user) }
end
