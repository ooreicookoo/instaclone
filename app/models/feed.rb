class Feed < ApplicationRecord
  belongs_to :user
  has_many :favorites
  mount_uploader :image, ImageUploader
  validates :content, presence: true

  def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
  end
end
