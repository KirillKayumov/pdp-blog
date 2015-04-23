class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :articles

  validates :full_name, presence: true

  def to_s
    full_name
  end
end
