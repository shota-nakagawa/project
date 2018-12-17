class Topic < ApplicationRecord
  validates :user_id, presence: true
  validates :description, presence: true
  validates :image, presence: true

  belongs_to :user
  has_many :comments
  has_many :comment_users, through: :comments, source: 'user'

  mount_uploader :image, ImageUploader

  # has_many :favorites, dependent: :destroy
  has_many :favorites
  has_many :favorite_users, through: :favorites, source: 'user'

  def favorite_user(user_id)
    favirites.find_by(user_id: user_id)
  end
end
