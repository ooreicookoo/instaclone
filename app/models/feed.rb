class Feed < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  mount_uploader :image, ImageUploader
  validates :image, presence: true
  validates :content, presence: true

  def favorited_by? user
    favorites.where(user_id: user.id).exists?
  end
end
