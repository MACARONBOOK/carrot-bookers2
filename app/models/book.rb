class Book < ApplicationRecord
  belongs_to :user
  has_one_attached :profile_image
  has_many :favorites, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
