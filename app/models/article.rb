class Article < ActiveRecord::Base
  belongs_to :user

  validates :title, :text, :user_id, presence: true
end
